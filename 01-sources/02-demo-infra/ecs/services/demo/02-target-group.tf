resource "aws_lb_target_group" "ecs_service" {
  name        = "${var.service_name}-default"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.dependency.networking.vpc_id

  health_check {
    enabled             = true
    path                = "/test"
    protocol            = "HTTP"
    port                = "traffic-port"
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}
