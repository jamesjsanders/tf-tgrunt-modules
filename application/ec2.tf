resource "aws_instance" "web" {
  count                  = var.web_instance_count
  ami                    = "${var.ec2_web_ami}"
  instance_type          = "${var.ec2_web_instance_type}"
  availability_zone      = "${var.availability_zone_b}"
  vpc_security_group_ids = ["${var.aws_security_group_private_id}"]
  iam_instance_profile   = "${aws_iam_instance_profile.ec2.name}"
  subnet_id              = "${var.aws_subnet_private1_id}"

  tags = {
    Name            = "web${count.index}.${var.vpc_main_name}"
    AmazonInspector = "True"
    Environment     = "${var.environment}"
    VPC             = "${var.vpc_main_name}"
  }

  volume_tags = {
    Name        = "web${count.index}.${var.vpc_main_name}"
    Environment = "${var.environment}"
    VPC         = "${var.vpc_main_name}"
  }

  root_block_device {
    volume_size = "16"
  }
}
