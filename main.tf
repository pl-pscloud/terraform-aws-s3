resource "aws_s3_bucket" "pscloud-s3-bucket" {
  bucket = "${var.pscloud_company}-bucket-${var.pscloud_purpouse}-${var.pscloud_env}"
  acl    = "private"

  versioning {
    enabled = var.pscloud_versioning
  }

  lifecycle_rule {
    id      = "archive"
    enabled = var.pscloud_lifecycle_enbaled

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 360
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.pscloud_company}_bucket_${var.pscloud_purpouse}_${var.pscloud_env}"
    Purpose     = var.pscloud_purpouse
  }
}