# kms-key 

Terraform module to provision a [KMS](https://aws.amazon.com/kms/) key with alias.

## Usage

```hcl
    module "kms_key" {
      source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=master"
      namespace               = "eg"
      stage                   = "test"
      name                    = "chamber"
      description             = "KMS key for chamber"
      deletion_window_in_days = 10
      enable_key_rotation     = true
      alias                   = "alias/parameter_store_key"
    }
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alias | The display name of the alias. The name must start with the word `alias` followed by a forward slash | string | `""` | no |
| attributes | Additional attributes (e.g. `1`) | list(string) | `[]` | no |
| aws\_profile |  | string | n/a | yes |
| aws\_region |  | string | n/a | yes |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource | string | `"10"` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `"-"` | no |
| description | The description of the key as viewed in AWS console | string | `"Parameter Store KMS master key"` | no |
| enable\_key\_rotation | Specifies whether key rotation is enabled | bool | `"true"` | no |
| enabled | Set to false to prevent the module from creating any resources | bool | `"true"` | no |
| name | Application or solution name (e.g. `app`) | string | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | `""` | no |
| policy | A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. | string | `""` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | `""` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_kms\_alias\_arn |  |
| aws\_kms\_key\_arn |  |
| aws\_kms\_key\_id |  |
| name |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

