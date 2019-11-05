module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.14.1"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  delimiter  = var.delimiter
  tags       = var.tags
}


# aws_kms_key key creation
resource "aws_kms_key" "kms_key" {
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy                  = var.policy
  tags                    = module.label.tags
  description             = var.description
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${var.name}"
  target_key_id = "${aws_kms_key.kms_key.key_id}"
}
