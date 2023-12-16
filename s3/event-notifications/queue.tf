resource "aws_sqs_queue" "queue" {
  name   = "s3-eve-queue"
  policy = data.aws_iam_policy_document.queue.json
}


data "aws_iam_policy_document" "queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:s3-eve-queue"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.default.arn]
    }
  }
}
output "queue_url" {
  value = aws_sqs_queue.queue.id
}