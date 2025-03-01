locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  s3_bucket_name = "max-global-s3-${random_integer.random_integer.result}"
}

resource "random_integer" "random_integer" {
  min = 10000
  max = 99999
}
