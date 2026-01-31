
// here are the outputs for the S3 bucket, Oac_id and cloudfront distribution id and s3 obejcts

output "bucket_name" {
    value = aws_s3_bucket.my_bucket.id
}
output "oac_id" {
    value = aws_cloudfront_origin_access_control.oac.id
  
}
output "cloudfront_distribution_id" {
    value = aws_cloudfront_distribution.s3_distribution.id
  
}

# output "aws_s3_object" {
# value = aws_s3_object.object[*].id
# }