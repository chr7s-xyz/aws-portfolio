














#cloudfront
resource "aws_cloudfront_distribution" "cdn" {
enabled = true
default_root_object = "index.html"

restrictions {
  geo_restriction {
    restriction_type = "none"
  }
}

origin {
domain_name = aws_s3_bucket.portfolio.bucket_regional_domain_name
origin_id = "s3-origin"


s3_origin_config {
origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
}
}


default_cache_behavior {
allowed_methods = ["GET", "HEAD"]
cached_methods = ["GET", "HEAD"]
target_origin_id = "s3-origin"


viewer_protocol_policy = "redirect-to-https"


forwarded_values {
query_string = false
cookies {
forward = "none"
}
}
}


viewer_certificate {
cloudfront_default_certificate = true
}
}


resource "aws_cloudfront_origin_access_identity" "oai" {
comment = "portfolio OAI"
}