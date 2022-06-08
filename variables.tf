variable "description" {
  type    = string
  default = "An infrastructure configuration for EC2 Image Builder."
}

variable "iam_instance_profile_name" {
  type        = string
  description = "The name of the IAM instance profile used when building images."
}

variable "instance_types" {
  type        = list(string)
  description = "The list of EC2 instance types to build."
  default     = ["t3.small"]
}

variable "key_name" {
  type        = string
  description = "Name of EC2 key pair used to connect to the instances."
  default     = ""
}

variable "logging_bucket" {
  type        = string
  description = "The name of the bucket that will receive the log objects."
  default     = ""
}

variable "logging_prefix" {
  type        = string
  description = "The key prefix to use when logging.  Defaults to \"imagebuilder/[NAME]/\" if not specified."
  default     = ""
}

variable "name" {
  type        = string
  description = "The name of the infrastructure configuration."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the VPC subnet used when building images."
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the infrastructure configuration."
  default     = {}
}

variable "terminate_instance_on_failure" {
  type        = bool
  description = "Enable if the instance should be terminated when the pipeline fails."
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC used when building images."
}
