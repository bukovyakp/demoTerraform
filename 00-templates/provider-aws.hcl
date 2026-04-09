generate "provider-aws" {
  path      = "gen_provider_aws.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region              = var.region
  profile             = var.profile
}
EOF
}
