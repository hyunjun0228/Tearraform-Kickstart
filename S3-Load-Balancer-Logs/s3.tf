##################################################################################
# DATA
##################################################################################

# AWS IAM Policy Document
# - Configuring LB access to S3
data "aws_iam_policy_document" "allow_access_alb" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.root.arn]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/alb-logs/*"
    ]
  }
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
      "s3:GetBucketAcl"
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/alb-logs/*",
      "arn:aws:s3:::${local.s3_bucket_name}"
    ]
  }
}

##################################################################################
# RESOURCES
##################################################################################

# S3 Bucket
resource "aws_s3_bucket" "max_global_s3" {
  bucket        = local.s3_bucket_name
  force_destroy = true

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-s3-bucket" })
}

# S3 Bucket Object
resource "aws_s3_object" "website" {
  bucket   = aws_s3_bucket.max_global_s3.id
  for_each = local.webcontent

  key    = each.value
  source = "${path.root}/${each.value}"

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-webcontent" })
}

# AWS S3 Bucket Policy
# - Need to grant access for LB to access S3 and write logs into bucket
resource "aws_s3_bucket_policy" "allow_access_alb" {
  bucket = aws_s3_bucket.max_global_s3.id
  policy = data.aws_iam_policy_document.allow_access_alb.json
}
