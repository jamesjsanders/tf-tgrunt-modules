resource "aws_route53_zone" "vpc" {
  name = "${var.vpc_main_name}"

  vpc {
    vpc_id = "${var.vpc_main_id}"
  }
}

resource "aws_route53_record" "web" {
  count   = var.web_instance_count
  zone_id = "${aws_route53_zone.vpc.zone_id}"
  name    = "web${count.index}.${var.vpc_main_name}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.web.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "db_master" {
  zone_id = "${aws_route53_zone.vpc.zone_id}"
  name    = "db.master.${var.vpc_main_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_db_instance.rds_master.address}"]
}

resource "aws_route53_record" "cache" {
  zone_id = "${aws_route53_zone.vpc.zone_id}"
  name    = "cache.master.${var.vpc_main_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elasticache_replication_group.cache.primary_endpoint_address}"]
}
