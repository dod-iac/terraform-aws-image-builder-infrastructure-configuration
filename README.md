<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates an infrastructure configuration for EC2 Image Builder.

```hcl
module "image_builder_instance_role" {
  source  = "dod-iac/ec2-instance-role/aws"
  version = "1.0.2"

  allow_image_builder = true
  name                = format("app-%s-image-builder-instance-role-%s", var.application, var.environment)
}

resource "aws_iam_instance_profile" "image_builder_instance_role" {
  name = module.image_builder_instance_role.name
  role = module.image_builder_instance_role.name
}

module "image_builder_infrastructure_configuration" {
  source = "dod-iac/image-builder-infrastructure-configuration/aws"

  iam_instance_profile_name     = aws_iam_instance_profile.image_builder_instance_role.name
  logging_bucket                = var.logging_bucket
  name                          = format("app-%s-%s", var.application, var.environment)
  subnet_id                     = coalesce(var.subnet_ids...)
  vpc_id                        = var.vpc_id
}

```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to main branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_imagebuilder_infrastructure_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_infrastructure_configuration) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"An infrastructure configuration for EC2 Image Builder."` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | The name of the IAM instance profile used when building images. | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | The list of EC2 instance types to build. | `list(string)` | <pre>[<br>  "t3.small"<br>]</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of EC2 key pair used to connect to the instances. | `string` | `""` | no |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | The name of the bucket that will receive the log objects. | `string` | `""` | no |
| <a name="input_logging_prefix"></a> [logging\_prefix](#input\_logging\_prefix) | The key prefix to use when logging.  Defaults to "imagebuilder/[NAME]/" if not specified. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the infrastructure configuration. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the VPC subnet used when building images. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to the infrastructure configuration. | `map(string)` | `{}` | no |
| <a name="input_terminate_instance_on_failure"></a> [terminate\_instance\_on\_failure](#input\_terminate\_instance\_on\_failure) | Enable if the instance should be terminated when the pipeline fails. | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC used when building images. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the EC2 Image Builder infrastructure configuration. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
