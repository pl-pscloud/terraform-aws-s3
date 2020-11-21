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
      days          = var.pscloud_transition_days_ia
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }

    transition {
      days          = var.pscloud_transition_days_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.pscloud_transition_days_expiration
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.pscloud_kms_key_arn == "" ? "AES256" : "aws:kms"
        kms_master_key_id = var.pscloud_kms_key_arn
      }
    }
  }

  tags = {
    Name        = "${var.pscloud_company}_bucket_${var.pscloud_purpouse}_${var.pscloud_env}"
    Purpose     = var.pscloud_purpouse
  }
}

resource "aws_s3_bucket_public_access_block" "pscloud-s3-bucket-block-access" {
  count                   = var.pscloud_block_access == true ? 1 : 0

  bucket                  = aws_s3_bucket.pscloud-s3-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}