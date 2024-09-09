resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
    Environment = "prod"
  }
}



resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_id  # Reference the KMS key created
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCrossAccountAccess",
        Effect    = "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"  # Replace with the root account for Account B
        },
        Action   = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.this.arn  # Assuming the S3 bucket resource is named "aws_s3_bucket.this"
}


data "aws_caller_identity" "current" {}