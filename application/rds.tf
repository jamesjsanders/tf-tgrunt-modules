resource "aws_db_parameter_group" "master" {
  name   = "master-11-1-b"
  family = "postgres11"

  parameter {
    name  = "log_min_error_statement"
    value = "error"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  parameter {
    name  = "statement_timeout"
    value = "120000"
  }
}

resource "aws_db_parameter_group" "mirror" {
  name   = "mirror-11-1-b"
  family = "postgres11"

  parameter {
    name  = "log_min_error_statement"
    value = "error"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  parameter {
    name  = "statement_timeout"
    value = "120000"
  }

  parameter {
    name  = "hot_standby_feedback"
    value = "1"
  }
}

resource "aws_db_parameter_group" "mirror-heavy" {
  name   = "mirror-11-1-b-heavy"
  family = "postgres11"

  parameter {
    name  = "log_min_error_statement"
    value = "error"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  parameter {
    name  = "statement_timeout"
    value = "0"
  }

  parameter {
    name  = "hot_standby_feedback"
    value = "1"
  }

  parameter {
    name  = "max_standby_archive_delay"
    value = "300000"
  }

  parameter {
    name  = "max_standby_streaming_delay"
    value = "300000"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.vpc_main_name}"
  subnet_ids = ["${var.aws_subnet_private1_id}", "${var.aws_subnet_private2_id}"]

  tags = {
    Name = "${var.vpc_main_name} subnet group"
  }
}

resource "random_string" "snapshot_id" {
  length  = 4
  special = false
}

resource "aws_db_instance" "rds_master" {
  identifier                      = "${var.vpc_main_name}-master"
  allocated_storage               = 20
  allow_major_version_upgrade     = false
  backup_retention_period         = "7"
  backup_window                   = "05:00-06:00"
  db_subnet_group_name            = "${aws_db_subnet_group.main.name}"
  storage_type                    = "gp2"
  engine                          = "postgres"
  engine_version                  = "11.1"
  instance_class                  = "db.t2.medium"
  kms_key_id                      = "${aws_kms_key.rds.arn}"
  maintenance_window              = "wed:06:00-wed:06:30"
  username                        = "root"
  password                        = "${var.rds_db_root_password}"
  parameter_group_name            = "master-11-1-b"
  publicly_accessible             = false
  storage_encrypted               = true
  vpc_security_group_ids          = ["${var.aws_security_group_private_id}"]
  performance_insights_enabled    = true
  performance_insights_kms_key_id = "${aws_kms_key.rds.arn}"
  final_snapshot_identifier       = "${var.vpc_main_name}-master-final-snapshot-${random_string.snapshot_id.result}"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  monitoring_role_arn             = "${aws_iam_role.rds_monitoring_role.arn}"
  monitoring_interval             = 30
}
