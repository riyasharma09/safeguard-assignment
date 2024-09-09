variable "description" {
  type        = string
  description = "Description for the KMS key"
}

variable "cross_account_arn" {
  type        = string
  description = "Cross-account ARN for access"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Number of days to wait before KMS key is deleted"
  default     = 30
}
