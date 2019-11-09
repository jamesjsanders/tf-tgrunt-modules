output "aws_vpc_main_name" {
  value = "${var.vpc_name}"
}

output "aws_vpc_main_id" {
  value = "${aws_vpc.main.id}"
}

output "aws_subnet_public1_id" {
  value = "${aws_subnet.public1.id}"
}

output "aws_subnet_public2_id" {
  value = "${aws_subnet.public2.id}"
}

output "aws_subnet_private1_id" {
  value = "${aws_subnet.private1.id}"
}

output "aws_subnet_private2_id" {
  value = "${aws_subnet.private2.id}"
}

output "security_group_private_id" {
  value = "${aws_security_group.private.id}"
}

output "aws_security_group_bastion_id" {
  value = "${aws_security_group.bastion.id}"
}

output "aws_security_group_elb_id" {
  value = "${aws_security_group.elb.id}"
}
