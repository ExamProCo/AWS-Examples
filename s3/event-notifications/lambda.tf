data "aws_iam_policy_document" "assume_role" {
  statement {
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
             "logs:PutLogEvents",
          ]
          Effect   = "Allow"
          Resource = "arn:aws:logs:*:*:*"
        },
      ] // statement
    }) //jsonencode
  } // inline_policy
} // resource

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.default.arn
}

resource "aws_lambda_function" "func" {
  function_name = "lambda-python-s3-events"
  filename      = data.archive_file.lambda_my_function.output_path
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "function.lambda_handler"
  runtime       = "python3.12"
}

# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file
data "archive_file" "lambda_my_function" {
  type             = "zip"
  source_file      = "${path.module}/function/function.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/function-000.zip"
}