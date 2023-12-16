# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "default" {
  # bucket name will randomly generated
}

#  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification
resource "aws_s3_bucket_notification" "default" {
  bucket = aws_s3_bucket.default.id
  eventbridge = true
  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:Put"]
    filter_prefix = "topic/"
    filter_suffix = ".json"
  }
  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:Put"]
    filter_prefix = "queue/"
    filter_suffix = ".json"
  }
  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_prefix       = "function/"
    filter_suffix = ".json"
  }
  depends_on = [aws_lambda_permission.allow_bucket]
}

output "s3_bucket_name" {
  value = aws_s3_bucket.default.id
}