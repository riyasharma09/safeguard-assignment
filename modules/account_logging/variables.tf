# CloudTrail variables
variable "trail_name" {
  description = "Name of the CloudTrail"
  type        = string
}

variable "cloudtrail_s3_bucket" {
  description = "S3 bucket for CloudTrail logs"
  type        = string
}

# VPC Flow Logs variables
variable "vpc_id" {
  description = "VPC ID for VPC Flow Logs"
  type        = string
}

variable "log_group_prefix" {
  description = "CloudWatch log group name prefix"
  type        = string
}

variable "log_retention_in_days" {
  description = "Retention period for CloudWatch Logs"
  type        = number
  default     = 7
}

# AWS Config variables
variable "config_recorder_name" {
  description = "Name of the AWS Config recorder"
  type        = string
}

variable "config_role_arn" {
  description = "IAM Role ARN for AWS Config"
  type        = string
}

variable "config_delivery_channel_name" {
  description = "Name of the AWS Config delivery channel"
  type        = string
}

variable "config_s3_bucket" {
  description = "S3 bucket for AWS Config logs"
  type        = string
}

# AWS Config Rule (S3 Encryption enabled check)
variable "s3_encryption_enabled_rule" {
  description = "AWS Config rule for S3 Bucket encryption"
  type        = bool
  default     = true
}

# CloudWatch Alarm variables
variable "unauthorized_access_alarm_name" {
  description = "Name of the CloudWatch alarm for unauthorized access"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN to send CloudWatch Alarm notifications"
  type        = string
}

# Tags
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
