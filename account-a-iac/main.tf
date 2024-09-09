provider "aws" {
  region  = var.region
  profile = var.aws_profile  # Use the profile defined in variables.tf
}

# VPC Creation in Account A
module "vpc_account_a" {
  source              = "../modules/vpc"
  cidr_block          = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  vpc_name            = var.vpc_name
  availability_zone   = var.availability_zone
  enable_s3_endpoint  = var.enable_s3_endpoint
  region              = var.region
}

# S3 Bucket Creation in Account A
module "s3_account_a" {
  source            = "../modules/s3"
  bucket_name       = var.s3_bucket_name
  kms_key_id        = module.kms_account_a.kms_key_id
  cross_account_arn = var.account_b_arn
}

# KMS Key Creation in Account A
module "kms_account_a" {
  source               = "../modules/kms"
  description          = var.kms_key_description
  cross_account_arn    = var.account_b_arn
}

module "lambda_data_transfer" {
  source              = "../modules/lambda_transfer"
  lambda_function_name = "S3DataTransferLambda"
  lambda_handler       = "lambda_function.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_zip_path      = "lambda_function.zip"  # Path to your zipped lambda code

  iam_role_arn         = module.iam_role_lambda.iam_role_arn  # Ensure you define this in IAM module or elsewhere
  source_bucket        = var.source_bucket
  source_key           = var.source_key
  dest_bucket          = var.dest_bucket
}

# IAM Role for Cross-Account Access in Account A
resource "aws_iam_role" "account_a_cross_account_role" {
  name = "AccountACrossAccountRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.account_b_arn  # Allow Account B to assume this role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "AccountACrossAccountRole"
  }
}

# Attach a policy to the IAM role allowing access to the S3 bucket
resource "aws_iam_role_policy" "account_a_s3_access_policy" {
  name   = "AccountACrossAccountS3Policy"
  role   = aws_iam_role.account_a_cross_account_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"  # Grant cross-account access to the S3 bucket
      }
    ]
  })
}

# IAM Role for Lambda (if not already defined elsewhere)
resource "aws_iam_role" "iam_lambda_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "LambdaExecutionRole"
  }
}

# Policy for Lambda to access S3
resource "aws_iam_role_policy" "lambda_s3_policy" {
  name   = "LambdaS3AccessPolicy"
  role   = aws_iam_role.iam_lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"  # Lambda access to the S3 bucket
      }
    ]
  })
}

# Outputs
output "s3_bucket_arn" {
  value = module.s3_account_a.s3_bucket_arn
}

output "kms_key_id" {
  value = module.kms_account_a.kms_key_id
}


output "cross_account_role_arn" {
  value = aws_iam_role.account_a_cross_account_role.arn
}


module "account_logging_account_a" {
  source                        = "./modules/account_logging"
  trail_name                    = "account-a-cloudtrail"
  cloudtrail_s3_bucket           = "cloudtrail-logs-account-a"
  vpc_id                        = module.vpc_account_a.vpc_id
  log_group_prefix              = "account-a"
  config_recorder_name          = "account-a-config-recorder"
  config_role_arn               = var.config_role_arn_a
  config_delivery_channel_name  = "account-a-config-channel"
  config_s3_bucket              = "config-logs-account-a"
  unauthorized_access_alarm_name = "AccountAUnauthorizedAccessAlarm"
  sns_topic_arn                 = aws_sns_topic.cloudwatch_alarms.arn
  
  tags = {
    Environment = "production"
    Account     = "AccountA"
  }
}
