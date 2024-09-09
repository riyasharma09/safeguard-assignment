# AWS Profile for CLI
variable "aws_profile" {
  type        = string
  description = "The AWS CLI profile to use for Account B"
  default     = "account-b"  # Replace with your profile name for Account B
}

# Account IDs
variable "account_a_arn" {
  type        = string
  description = "ARN of Account A (used for cross-account access to resources in Account B)"

}

variable "account_b_id" {
  type        = string
  description = "AWS Account ID for Account B"
  default = "537124975343"
}

# VPC and Subnets
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC in Account B"
  default     = "10.2.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet in Account B"
  default     = "10.2.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet in Account B"
  default     = "10.2.2.0/24"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC in Account B"
  default     = "account-b-vpc"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the VPC subnets"
  default     = "ap-south-1a"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "ap-south-1"
}

# S3 Bucket
variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for data in Account B"
  default     = "account-b-sg-data-bucket"
}

# KMS Key
variable "kms_key_description" {
  type        = string
  description = "Description for the KMS key for S3 encryption in Account B"
  default     = "KMS key for S3 encryption in Account B"
}

# IAM Role
# IAM Role
variable "iam_role_name" {
  type        = string
  description = "Name of the IAM role for cross-account access in Account B"
  default     = "AccountBCrossAccountRole"
}

variable "iam_policy_name" {
  type        = string
  description = "Name of the IAM policy for the role"
  default     = "AccountBPolicy"
}

# PrivateLink / VPC Endpoint
variable "enable_s3_endpoint" {
  type        = bool
  description = "Flag to enable or disable S3 VPC endpoint in Account B"
  default     = true
}


# PrivateLink Service Name from Account A
variable "private_link_service_name" {
  type        = string
  description = "The PrivateLink service name from Account A that this VPC endpoint will connect to"
}