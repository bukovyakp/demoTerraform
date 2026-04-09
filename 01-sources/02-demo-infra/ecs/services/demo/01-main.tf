locals {
  service_name   = var.service_name
  container_name = var.container_name
}

resource "aws_ecs_task_definition" "app" {
  family                   = local.service_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = local.container_name
      image     = var.container_image

      portMappings = [
        {
          name          = "app-8080"
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])

}

resource "aws_ecs_service" "app" {
  name            = local.service_name
  cluster         = local.dependency.ecs_cluster.cluster_arn
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [for id in local.dependency.networking.public_subnets : id]
    security_groups  = [local.dependency.security_groups.sg_allow_trusted]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_service.arn
    container_name   = local.container_name
    container_port   = 8080
  }

  depends_on = [
    aws_lb_listener_rule.ecs_service_demo
  ]
}
