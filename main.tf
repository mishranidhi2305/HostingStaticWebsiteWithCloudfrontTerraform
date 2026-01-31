// creaeting a s3 bucket here
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.name}-${var.customer}-${var.environment}-${var.region}"
}

# Restricting it for public access.
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Defining Origin access control for cloudfront

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.name}-${var.customer}-${var.environment}-${var.region}"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

