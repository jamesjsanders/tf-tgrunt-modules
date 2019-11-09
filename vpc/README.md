# VPC Module

## This is the base VPC module

The module contains the configuration of AWS VPC

* VPC
* Subnets
* Security Groups
* Gateways
* Routes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_zone\_b | vpc desired CIDR block | string | n/a | yes |
| availability\_zone\_d | vpc desired CIDR block | string | n/a | yes |
| aws\_profile | The AWS profile to use for deploy | string | n/a | yes |
| aws\_region | The AWS region to deploy to (e.g. us-east-1) | string | n/a | yes |
| environment | Environment for vpc (production, staging, etc) | string | n/a | yes |
| private1\_subnet | Private 1 Subnet | string | n/a | yes |
| private2\_subnet | Private 2 Subnet | string | n/a | yes |
| public1\_subnet | Public 1 Subnet | string | n/a | yes |
| public2\_subnet | Public 2 Subnet | string | n/a | yes |
| vpc\_cidr\_block | vpc desired CIDR block | string | `"10.0.0.0/16"` | no |
| vpc\_name | VPC Name | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_security\_group\_bastion\_id |  |
| aws\_security\_group\_elb\_id |  |
| aws\_security\_group\_private\_id |  |
| aws\_subnet\_private1\_id |  |
| aws\_subnet\_private2\_id |  |
| aws\_subnet\_public1\_id |  |
| aws\_subnet\_public2\_id |  |
| aws\_vpc\_main\_id |  |
| aws\_vpc\_main\_name | Requires Terraform 0.12.0 or above. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
