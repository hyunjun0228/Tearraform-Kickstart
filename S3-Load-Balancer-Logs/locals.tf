locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
    environment  = var.environment
  }

  naming_prefix  = "${lower(var.naming_prefix)}-${lower(var.environment)}"
  s3_bucket_name = "${local.naming_prefix}-${random_integer.random_integer.result}"
  webcontent = {
    homepage = "/website/index.html"
    logo     = "/website/max_logo.jpg"
  }
}

resource "random_integer" "random_integer" {
  min = 10000
  max = 99999
}
