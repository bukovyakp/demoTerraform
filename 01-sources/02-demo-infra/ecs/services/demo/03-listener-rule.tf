resource "aws_lb_listener_rule" "ecs_service_demo" {
  listener_arn = local.dependency.alb.http_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_service.arn
  }

  condition {
    path_pattern {
      values = ["/test"]
    }
  }
}
