resource "aws_lb" "pub_alb" {
  name            = var.lb_name
  security_groups = [local.dependency.security_groups.sg_allow_web]
  subnets         = [for id in local.dependency.networking.public_subnets : id]
}
