#s3 bucket --> add all hosting files here
resource "aws_s3_bucket" "portfolio" {
  bucket = "portfolio-bucket"
}

resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket                  = aws_s3_bucket.portfolio.id
  block_public_acls        = true
  block_public_policy     = true
  ignore_public_acls       = true
  restrict_public_buckets = true
}