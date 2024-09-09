resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = var.iam_role_arn
  filename      = var.lambda_zip_path  # Path to the lambda deployment package (ZIP file)

  environment {
    variables = {
      SOURCE_BUCKET = var.source_bucket
      SOURCE_KEY    = var.source_key
      DEST_BUCKET   = var.dest_bucket
    }
  }

  tags = {
    Name        = var.lambda_function_name
    Environment = "Prod"
  }
}

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.source_bucket}"  # Grant S3 bucket permission to invoke the Lambda function
}

output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
}
