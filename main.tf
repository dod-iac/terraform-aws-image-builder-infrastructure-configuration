/**
 * ## Usage
 *
 * Creates an infrastructure configuration for EC2 Image Builder.
 *
 * ```hcl
 * module "image_builder_instance_role" {
 *   source  = "dod-iac/ec2-instance-role/aws"
 *   version = "1.0.2"
 *
 *   allow_image_builder = true
 *   name                = format("app-%s-image-builder-instance-role-%s", var.application, var.environment)
 * }
 *
 * resource "aws_iam_instance_profile" "image_builder_instance_role" {
 *   name = module.image_builder_instance_role.name
 *   role = module.image_builder_instance_role.name
 * }
 *
 * module "image_builder_infrastructure_configuration" {
 *   source = "dod-iac/image-builder-infrastructure-configuration/aws"
 *
 *   iam_instance_profile_name     = aws_iam_instance_profile.image_builder_instance_role.name
 *   logging_bucket                = var.logging_bucket
 *   name                          = format("app-%s-%s", var.application, var.environment)
 *   subnet_id                     = coalesce(var.subnet_ids...)
 *   vpc_id                        = var.vpc_id
 * }
 *
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to main branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

resource "aws_security_group" "main" {
  name        = var.name
  description = format("Security group for the %s infrastructure configuration for EC2 Image Builder", var.name)
  vpc_id      = var.vpc_id
  tags        = var.tags

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_imagebuilder_infrastructure_configuration" "main" {
  description                   = var.description
  instance_profile_name         = var.iam_instance_profile_name
  instance_types                = var.instance_types
  key_pair                      = length(var.key_name) > 0 ? var.key_name : null
  name                          = var.name
  security_group_ids            = [aws_security_group.main.id]
  subnet_id                     = var.subnet_id
  tags                          = var.tags
  terminate_instance_on_failure = var.terminate_instance_on_failure

  dynamic "logging" {
    for_each = length(var.logging_bucket) > 0 ? [1] : []
    content {
      s3_logs {
        s3_bucket_name = var.logging_bucket
        s3_key_prefix  = length(var.logging_prefix) > 0 ? var.logging_prefix : format("ec2-image-builder/%s", var.name)
      }
    }
  }
}
