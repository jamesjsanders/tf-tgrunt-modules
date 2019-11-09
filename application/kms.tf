resource "aws_kms_key" "rds" {
  description = "RDS key for ${var.environment} ${var.vpc_main_name}"
}

resource "aws_kms_alias" "rds" {
  name          = "alias/ff/rds-${var.vpc_main_name}"
  target_key_id = "${aws_kms_key.rds.arn}"
}

resource "aws_kms_key" "s3" {
  description = "S3 key for ${var.environment} ${var.vpc_main_name}"
}

resource "aws_kms_alias" "s3" {
  name          = "alias/ff/s3-${var.vpc_main_name}"
  target_key_id = "${aws_kms_key.s3.arn}"
}