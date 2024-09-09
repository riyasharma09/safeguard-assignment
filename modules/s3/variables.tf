variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key ID for bucket encryption"
}

variable "enable_versioning" {
  type        = bool
  description = "Enable versioning for the bucket"
  default     = true
}

variable "cross_account_arn" {
  type        = string
  description = "Cross-account ARN for access"
}
