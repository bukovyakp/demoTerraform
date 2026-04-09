include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

generate = merge(
  include.region.locals.provider-aws,
  include.region.locals.variables-common
)

terraform {
  source = "${get_repo_root()}/01-sources/02-demo-infra/ecs/services/demo//."
}

inputs = {
  service_name    = "demo-service"
  container_name  = "go-rest-api"
  container_image = "chentex/go-rest-api:latest"
}

