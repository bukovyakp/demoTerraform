#aws dynamodb create-table \
#  --table-name interview-terraform-state-locks-eu-west-1 \
#  --attribute-definitions AttributeName=LockID,AttributeType=S \
#  --key-schema AttributeName=LockID,KeyType=HASH \
#  --billing-mode PAY_PER_REQUEST \
#  --region eu-west-1

inputs = local

locals {
  region              = "eu-west-1"
  profile             = "main-demo"
  environment_name    = "main-demo"
  remote_state_bucket = "interview-terraform-state-20210216150437952100000001"
  dynamodb_table      = "interview-terraform-state-locks-eu-west-1"

  provider-aws     = read_terragrunt_config("${get_path_to_repo_root()}/00-templates/provider-aws.hcl").generate
  variables-common = read_terragrunt_config("${get_path_to_repo_root()}/00-templates/variables-common.hcl").generate
}


remote_state {
  backend = "s3"

  generate = {
    path      = "gen_backend.tf"
    if_exists = "overwrite"
  }
  config = {
    region         = local.region
    profile        = local.profile
    bucket         = local.remote_state_bucket
    key            = format("%s/%s/terraform.tfstate", local.region, path_relative_to_include())
    encrypt        = true
    dynamodb_table = local.dynamodb_table
  }
}
