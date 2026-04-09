include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

generate = merge(
  include.region.locals.provider-aws,
  include.region.locals.variables-common
)

terraform {
  source = "${get_repo_root()}/01-sources/01-pre-setup/vpc/security-groups/global//."
}

inputs = {
}
