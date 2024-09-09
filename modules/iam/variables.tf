variable "role_name" {
  type        = string
  description = "Name of the IAM role"
}

variable "assume_role_principal" {
  type        = string
  description = "Principal allowed to assume the role"
}

variable "policy_name" {
  type        = string
  description = "Name of the policy"
}

variable "policy_document" {
  type        = string
  description = "IAM policy document"
}
