generate "variables-common" {
  path      = "gen_variables_common.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
  variable "region" {
    description = "The AWS region where resources will be created."
    type        = string
  }

  variable "environment_name" {
    description = "The name of the environment"
    type        = string
  }

  variable "profile" {
    description = "The AWS CLI profile to use for authentication."
    type        = string
  }

  variable "remote_state_bucket" {
    description = "The name of the S3 bucket used for storing Terraform remote states."
    type        = string
  }
  EOF
}
