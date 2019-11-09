# Application Module

## This is the base application module

The module contains the configuration for the application infrastructure

* ec2
* load balancers (lb)
* ElastiCache
* Route53
* rds
* kms
* s3

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_zone\_b | Availability Zone B | string | n/a | yes |
| availability\_zone\_d | Availability Zone D | string | n/a | yes |
| aws\_region | The AWS region to deploy to (e.g. us-east-1) | string | n/a | yes |
| aws\_security\_group\_bastion\_id | Security Group Bastion ID | string | n/a | yes |
| aws\_security\_group\_elb\_id | Security Group ELB ID | string | n/a | yes |
| aws\_security\_group\_private\_id | Security Group Private ID | string | n/a | yes |
| aws\_subnet\_private1\_id | Subnet Private 1 ID | string | n/a | yes |
| aws\_subnet\_private2\_id | Subnet Private 2 ID | string | n/a | yes |
| aws\_subnet\_public1\_id | Subnet Public 1 ID | string | n/a | yes |
| aws\_subnet\_public2\_id | Subnet Public 2 ID | string | n/a | yes |
| ec2\_web\_ami | EC2 AMI | string | n/a | yes |
| ec2\_web\_instance\_type | EC2 AMI | string | `"t3a.medium"` | no |
| elasticache\_group\_node\_size | Elasticache Group Node Size | string | `"cache.t2.micro"` | no |
| elasticache\_number\_cache\_clusters | Elasticache Cache Cluster Count | number | `"2"` | no |
| environment | Environment for vpc (production, staging, etc) | string | n/a | yes |
| maintenance\_window | Maintenance Window | string | n/a | yes |
| rds\_db\_root\_password | RDS Root Password | string | n/a | yes |
| vpc\_main\_id | VPC Main ID | string | n/a | yes |
| vpc\_main\_name | VPC Main Name | string | n/a | yes |
| web\_instance\_count | Number of Web instances to launch | number | `"1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_app\_bucket\_name | Requires Terraform 0.12.0 or above. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
