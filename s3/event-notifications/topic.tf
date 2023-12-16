resource "aws_sns_topic" "topic" {
  name   = "s3-eve-topic"
  policy = data.aws_iam_policy_document.topic.json
}

data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:s3-eve-topic"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.default.arn]
    }
  }
}

resource "aws_sns_topic_subscription" "default" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "https"
  endpoint  = "https://4567-examproco-awsexamples-nhcz01r37xo.ws-us107.gitpod.io/data"
  endpoint_auto_confirms = true
}