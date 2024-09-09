variable "lambda_zip_path" {
  type        = string
  description = "Path to the zipped Lambda function"
}

variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "iam_role_arn" {
  type        = string
  description = "IAM Role ARN for the Lambda function"
}

variable "lambda_handler" {
  type        = string
  description = "Handler function for the Lambda"
}

variable "runtime" {
  type        = string
  description = "Runtime for the Lambda function"
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
}
