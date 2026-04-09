output "service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.app.id
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.app.arn
}

output "target_group_arn" {
  description = "ARN of the ALB target group for the ECS service"
  value       = aws_lb_target_group.ecs_service.arn
}

output "listener_rule_arn" {
  description = "ARN of the ALB listener rule routing /test to the ECS service"
  value       = aws_lb_listener_rule.ecs_service_demo.arn
}
