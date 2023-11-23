resource "aws_s3_bucket" "my-s3-bucket" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}