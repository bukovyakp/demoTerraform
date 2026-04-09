locals {
  dependency = {for k, v in data.terraform_remote_state.dependency : k => v.outputs}
}

data "terraform_remote_state" "dependency" {
  for_each = {
    networking      = "${var.region}/01-pre-setup/vpc/vpcs"
    security_groups = "${var.region}/01-pre-setup/vpc/security-groups/global"
    ecs_cluster     = "${var.region}/02-demo-infra/ecs/cluster/demo-fargate"
    alb             = "${var.region}/02-demo-infra/alb/demo-alb"
  }

  backend = "s3"

  config = {
    bucket  = var.remote_state_bucket
    key     = "${each.value}/terraform.tfstate"
    region  = var.region
    profile = var.profile
  }
}
