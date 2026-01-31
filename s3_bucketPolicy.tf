# Attaching policy to S3 bucket
resource "aws_s3_bucket_policy" "s3BucketPolicy" {
 bucket = aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {

     # Defines who is allowed to access the bucket Here, access is granted to a specific AWS account
    # principals {
    #   type        = "AWS"
    #   identifiers = ["accountid"]
    # }

    # Here acess is granted to the clodufront service, to access the bucket.
    principals {
    type        = "Service"
    identifiers = ["cloudfront.amazonaws.com"]
    }

    # Allowed actions on the S3 bucket
    actions = [
      "s3:GetObject",   # Allows reading/downloading objects from the bucket
      "s3:ListBucket"  # Allows listing objects inside the bucket
    ]
     # Resources on which the actions are allowed
    resources = [
      aws_s3_bucket.my_bucket.arn,        # Bucket-level access (required for ListBucket)
      "${aws_s3_bucket.my_bucket.arn}/*"  # Object-level access (required for GetObject)
    ]

    # Defining that only the particular cloudfrontdistribution can access the s3 bucket.
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

