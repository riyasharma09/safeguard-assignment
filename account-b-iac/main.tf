provider "aws" {
  region  = var.region
  profile = var.aws_profile  # Optional: only needed if you are using multiple AWS CLI profiles
}

# VPC Module for Account B
module "vpc_account_b" {
  source              = "../modules/vpc"
  cidr_block          = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  vpc_name            = var.vpc_name
  availability_zone   = var.availability_zone
  enable_s3_endpoint  = var.enable_s3_endpoint
  region              = var.region
}

# S3 Bucket Module for Account B
module "s3_account_b" {
  source            = "../modules/s3"
  bucket_name       = var.s3_bucket_name
  kms_key_id        = module.kms_account_b.kms_key_id  # This should be correct if the KMS module outputs the kms_key_id
  cross_account_arn = ""  # No cross-account access needed for now
}

# KMS Key Module for Account B
module "kms_account_b" {
  source            = "../modules/kms"
  description       = var.kms_key_description
  cross_account_arn = ""  # Cross-account permissions for later, can leave blank for now
}

# IAM Role Module for Account B (Allow Account A to Assume)
module "iam_role_account_b" {
  source               = "../modules/iam"
  role_name            = var.iam_role_name
  assume_role_principal = var.account_a_arn  # Allow Account A to assume this role
  policy_name          = var.iam_policy_name
  policy_document      = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": "${module.s3_account_b.s3_bucket_arn}"  # Ensure s3_bucket_arn is output from the s3 module
      }
    ]
  }
  POLICY
}

# Security Group for VPC Interface Endpoint
resource "aws_security_group" "account_b_sg" {
  vpc_id = module.vpc_account_b.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]  # Adjust according to Account A's VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "account-b-private-link-sg"
  }
}

# VPC Interface Endpoint for PrivateLink (Connect to Account A's PrivateLink)
resource "aws_vpc_endpoint" "private_link_interface" {
  vpc_id            = module.vpc_account_b.vpc_id
  service_name      = var.private_link_service_name  # PrivateLink service name from Account A
  vpc_endpoint_type = "Interface"
  subnet_ids        = module.vpc_account_b.private_subnet_ids  # Ensure correct output for private subnets
  security_group_ids = [aws_security_group.account_b_sg.id]

  tags = {
    Name = "account-b-private-link-endpoint"
  }
}

# Outputs (Optional: Useful for tracking resources)
output "s3_bucket_arn" {
  value = module.s3_account_b.s3_bucket_arn
}

output "kms_key_id" {
  value = module.kms_account_b.kms_key_id
}

output "vpc_id" {
  value = module.vpc_account_b.vpc_id
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.private_link_interface.id
}


module "account_logging_account_b" {
  source                        = "./modules/account_logging"
  trail_name                    = "account-b-cloudtrail"
  cloudtrail_s3_bucket           = "cloudtrail-logs-account-b"
  vpc_id                        = module.vpc_account_b.vpc_id
  log_group_prefix              = "account-b"
  config_recorder_name          = "account-b-config-recorder"
  config_role_arn               = var.config_role_arn_b
  config_delivery_channel_name  = "account-b-config-channel"
  config_s3_bucket              = "config-logs-account-b"
  unauthorized_access_alarm_name = "AccountBUnauthorizedAccessAlarm"
  sns_topic_arn                 = aws_sns_topic.cloudwatch_alarms.arn
  
  tags = {
    Environment = "production"
    Account     = "AccountB"
  }
}