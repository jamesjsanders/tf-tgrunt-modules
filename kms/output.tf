output "aws_kms_key_id" {
  value = "${aws_kms_key.kms_key.id}"
}

output "aws_kms_key_arn" {
  value = "${aws_kms_key.kms_key.arn}"
}

output "aws_kms_alias_arn" {
  value = "${aws_kms_alias.kms_alias.arn}"
}

output "name" {
  value = "${var.name}"
}
