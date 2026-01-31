
// creating cloudfront distribution with OAC to connect s3 bucket

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = local.s3_origin_id
  }
  
  enabled             = true
  comment             = "Connecting S3 bucket with CloudFront using OAC"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = var.allowed_countries
    }
  }
#  restrictions {
#     geo_restriction  {
#       restriction_type = "none"
#     }   
#   }

  tags = {
    Name = "${var.name}-${var.customer}-${var.environment}-${var.region}"
  }

  viewer_certificate {
   cloudfront_default_certificate = true
  }
}
