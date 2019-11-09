resource "aws_iam_policy" "s3_app_access" {
  name = "FF${var.vpc_main_name}S3AppAccess"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::prorated-${var.vpc_main_name}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::prorated-${var.vpc_main_name}/avatar-processing/*",
                "arn:aws:s3:::prorated-${var.vpc_main_name}/bulk_import/*",
                "arn:aws:s3:::prorated-${var.vpc_main_name}/exports/*",
                "arn:aws:s3:::prorated-${var.vpc_main_name}/media/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "s3_backups" {
  name = "FF${var.vpc_main_name}S3Backups"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions"
            ],
            "Resource": [
                "arn:aws:s3:::prorated-${var.vpc_main_name}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::prorated-${var.vpc_main_name}/backups/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "s3_sanitized_db" {
  name = "FF${var.vpc_main_name}SanitizedDBDumpPUTS3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::prorated-${var.vpc_main_name}/sanitized-dumps/*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "ec2" {
  name = "FFServiceRoleFor${var.vpc_main_name}Instances"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "monitoring.rds.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_iam_role_policy_attachment" "s3_app_access" {
  role       = "${aws_iam_role.ec2.name}"
  policy_arn = "${aws_iam_policy.s3_app_access.arn}"
}

resource "aws_iam_role_policy_attachment" "s3_backups" {
  role       = "${aws_iam_role.ec2.name}"
  policy_arn = "${aws_iam_policy.s3_backups.arn}"
}

resource "aws_iam_role_policy_attachment" "s3_sanitized_db" {
  role       = "${aws_iam_role.ec2.name}"
  policy_arn = "${aws_iam_policy.s3_sanitized_db.arn}"
}

data "aws_iam_policy" "iam-rds-enhanced-monitoring-access-policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_role" {
  role       = "${aws_iam_role.rds_monitoring_role.name}"
  policy_arn = "${data.aws_iam_policy.iam-rds-enhanced-monitoring-access-policy.arn}"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "FFServiceRoleFor${var.vpc_main_name}Instances"
  role = "${aws_iam_role.ec2.name}"
}
