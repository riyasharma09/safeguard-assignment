variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "The handler for the lambda function"
  type        = string
  default     = "lambda_function.lambda_handler"  # Handler in the Python code
}

variable "lambda_runtime" {
  description = "The runtime for the lambda function"
  type        = string
  default     = "python3.8"
}

variable "lambda_zip_path" {
  description = "Path to the ZIP file containing the lambda code"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role for the Lambda function"
  type        = string
}

variable "source_bucket" {
  description = "The S3 bucket name in Account A where the file resides"
  type        = string
}

variable "source_key" {
  description = "The S3 object key in Account A"
  type        = string
}

variable "dest_bucket" {
  description = "The S3 bucket name in Account B where the file will be transferred"
  type        = string
}
