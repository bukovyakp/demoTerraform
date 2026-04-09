include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

generate = merge(
  include.region.locals.provider-aws,
  include.region.locals.variables-common
)

terraform {
  source = "${get_repo_root()}/01-sources/01-pre-setup/vpc/vpcs//."
}

inputs = {
  cidr = "10.10.0.0/16"
  name = "main-demo"

  public_subnet_cidr = {
    demo_public = [
      "10.10.0.0/21",
      "10.10.8.0/21"
    ]
  }

  public_subnets = ["demo-pub"]
  azs            = ["eu-west-1a", "eu-west-1b"]
}
