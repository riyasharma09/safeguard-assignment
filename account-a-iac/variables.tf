# Account IDs

variable "aws_profile" {
  type        = string
  description = "The AWS CLI profile to use"
  default     = "account-a" 
}


variable "account_a_id" {
  type        = string
  description = "AWS Account ID for Account A"
  default = "116358018039"
}

variable "account_b_id" {
  type        = string
  description = "AWS Account ID for Account B"
  default = "537124975343"
}

# VPC and Subnets
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC in Account A"
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet in Account A"
  default     = "10.20.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet in Account A"
  default     = "10.20.2.0/24"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC in Account A"
  default     = "account-a-vpc"
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
  description = "Name of the S3 bucket for sensitive data in Account A"
  default     = "account-a-sg-sensitive-data"
}

# KMS Key
variable "kms_key_description" {
  type        = string
  description = "Description for the KMS key for S3 encryption in Account A"
  default     = "KMS key for S3 encryption in Account A"
}

# Lambda Function
variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function for data transfer"
  default     = "S3DataTransferLambda"
}

variable "lambda_zip_path" {
  type        = string
  description = "Path to the zipped Lambda code"
  default     = "lambda.zip"
}

variable "lambda_handler" {
  type        = string
  description = "Lambda function handler"
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  type        = string
  description = "Runtime environment for the Lambda function"
  default     = "python3.8"
}

# Cross-Account S3 Access
variable "account_b_arn" {
  type        = string
  description = "ARN for Account B (used for cross-account access to S3)"
  default = ""
}

variable "s3_bucket_account_b" {
  type        = string
  description = "S3 bucket name in Account B for data transfer"
  default = "account-b-sg-data-bucket"
}

# PrivateLink / VPC Endpoint
variable "lb_name" {
  type        = string
  description = "Name of the Network Load Balancer used for PrivateLink"
  default     = "s3-private-link-nlb"
}

variable "enable_s3_endpoint" {
  type        = bool
  description = "Flag to enable or disable S3 VPC endpoint"
  default     = true
}


# Lambda function name
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "S3DataTransferLambda"
}

# Lambda handler (Python entry point)
variable "lambda_handler" {
  description = "The handler for the lambda function"
  type        = string
  default     = "lambda_function.lambda_handler"
}

# Lambda runtime environment
variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "python3.8"
}

# Lambda deployment package path (ZIP file containing the Lambda code)
variable "lambda_zip_path" {
  description = "Path to the ZIP file containing the lambda code"
  type        = string
  default     = "lambda_function.zip"  # Adjust this to the actual path of your deployment package
}

# IAM Role ARN for the Lambda function
variable "iam_role_arn" {
  description = "IAM role for the Lambda function"
  type        = string
}

# Source S3 Bucket in Account A
variable "source_bucket" {
  description = "The S3 bucket name in Account A where the file resides"
  type        = string
}

# Source S3 Key (the file name) in Account A
variable "source_key" {
  description = "The S3 object key in Account A"
  type        = string
}

# Destination S3 Bucket in Account B
variable "dest_bucket" {
  description = "The S3 bucket name in Account B where the file will be transferred"
  type        = string
}
