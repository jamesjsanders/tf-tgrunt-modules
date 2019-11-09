resource "aws_s3_bucket" "log" {
  bucket = "prorated-logs-${var.vpc_main_name}"
  acl    = "log-delivery-write"
  region = "${var.aws_region}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.s3.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id                                     = "Delete after 6 months"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 180
    }

    noncurrent_version_expiration {
      days = 1
    }
  }
}

resource "aws_s3_bucket" "app" {
  bucket = "prorated-${var.vpc_main_name}"
  acl    = "log-delivery-write"
  region = "${var.aws_region}"

  logging {
    target_bucket = "${aws_s3_bucket.log.id}"
    target_prefix = "s3/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.s3.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*.prorated.com"]
    max_age_seconds = 30
  }

  lifecycle_rule {
    id                                     = "exports"
    prefix                                 = "exports/company"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    expiration {
      days = 7
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  lifecycle_rule {
    id                                     = "logs"
    prefix                                 = "logs"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 180
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  lifecycle_rule {
    id                                     = "bulk_import"
    prefix                                 = "bulk_import"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 90
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  lifecycle_rule {
    id                                     = "backups/grafana"
    prefix                                 = "backups/grafana"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    expiration {
      days = 14
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  lifecycle_rule {
    id                                     = "backups/influxdb"
    prefix                                 = "backups/influxdb"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    expiration {
      days = 14
    }

    noncurrent_version_expiration {
      days = 1
    }
  }
}
