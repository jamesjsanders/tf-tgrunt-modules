resource "aws_security_group" "bastion" {
  name   = "${var.vpc_name}.bastion"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Initial ssh port. Switched to 155 after server setup."
  }

  ingress {
    from_port   = 155
    to_port     = 155
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "prorated ssh"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb" {
  name   = "${var.vpc_name}.elb"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private" {
  name   = "${var.vpc_name}.private"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
    description     = "Initial ssh port. Switched to 155 after server setup."
  }

  ingress {
    from_port       = 155
    to_port         = 155
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
    description     = "prorated ssh"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
