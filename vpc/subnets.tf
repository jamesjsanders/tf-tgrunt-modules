resource "aws_subnet" "public1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public1_subnet}"
  availability_zone = "${data.aws_availability_zone.b.name}"

  tags = {
    Name = "${var.vpc_name}.public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public2_subnet}"
  availability_zone = "${data.aws_availability_zone.d.name}"

  tags = {
    Name = "${var.vpc_name}.public2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private1_subnet}"
  availability_zone = "${var.availability_zone_b}"

  tags = {
    Name = "${var.vpc_name}.private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private2_subnet}"
  availability_zone = "${var.availability_zone_d}"

  tags = {
    Name = "${var.vpc_name}.private2"
  }
}