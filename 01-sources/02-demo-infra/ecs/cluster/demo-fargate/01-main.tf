module "ecs_cluster" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecs.git//modules/cluster?ref=v7.5.0"

  name = var.cluster_name

  cluster_capacity_providers = ["FARGATE"]
}
