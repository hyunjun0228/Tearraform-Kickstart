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
}

# AWS IAM Policy Document
# - Configuring AWS Log Delivery Service access to S3
data "aws_iam_policy_document" "allow_access_alds" {
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

  tags = local.common_tags
}

# S3 Bucket Object
resource "aws_s3_object" "website" {
  bucket = local.s3_bucket_name
  key    = "/website/index.html"
  source = "./website/index.html"

  tags = local.common_tags
}

# AWS S3 Object
resource "aws_s3_object" "graphic" {
  bucket = local.s3_bucket_name
  key    = "/website/Globo_logo_Vert.png"
  source = "./website/Globo_logo_Vert.png"

  tags = local.common_tags
}

# AWS S3 Bucket Policy
# - Need to grant access for LB to access S3 and write logs into bucket
resource "aws_s3_bucket_policy" "allow_access_alb" {
  bucket = local.s3_bucket_name
  policy = data.aws_iam_policy_document.allow_access_alb.json
}

resource "aws_s3_bucket_policy" "allow_access_alds" {
  bucket = local.s3_bucket_name
  policy = data.aws_iam_policy_document.allow_access_alds.json
}
