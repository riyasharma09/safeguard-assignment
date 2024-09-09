resource "aws_kms_key" "this" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"  # Replace with the root account for Account B
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  })
}

output "kms_key_id" {
  value = aws_kms_key.this.id
}

data "aws_caller_identity" "current" {}
