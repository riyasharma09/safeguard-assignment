output "s3_bucket_arn" {
  value = module.s3_account_b.s3_bucket_arn  # Reference the module's output
}

# output "iam_role_arn" {
#   value = module.iam_role_account_b.role_arn  # Reference the module's output (make sure the module outputs role_arn)
# }