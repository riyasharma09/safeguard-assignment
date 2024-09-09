resource "aws_lambda_function" "this" {
  filename         = var.lambda_zip_path
  function_name    = var.function_name
  role             = var.iam_role_arn
  handler          = var.lambda_handler
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = var.environment_variables
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowInvocationFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
}
