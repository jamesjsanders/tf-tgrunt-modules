resource "aws_elasticache_subnet_group" "cache" {
  name       = "${var.vpc_main_name}"
  subnet_ids = ["${var.aws_subnet_private1_id}", "${var.aws_subnet_private2_id}"]
}

resource "aws_elasticache_replication_group" "cache" {
  automatic_failover_enabled    = true
  at_rest_encryption_enabled    = true
  replication_group_id          = "${var.vpc_main_name}"
  replication_group_description = "${var.vpc_main_name}"
  availability_zones            = ["${var.availability_zone_b}", "${var.availability_zone_d}"]
  node_type                     = "${var.elasticache_group_node_size}"
  engine                        = "redis"
  engine_version                = "5.0.0"
  maintenance_window            = "${var.maintenance_window}"
  number_cache_clusters         = "${var.elasticache_number_cache_clusters}"
  parameter_group_name          = "default.redis5.0"
  security_group_ids            = ["${var.aws_security_group_private_id}"]
  subnet_group_name             = "${aws_elasticache_subnet_group.cache.name}"
}
