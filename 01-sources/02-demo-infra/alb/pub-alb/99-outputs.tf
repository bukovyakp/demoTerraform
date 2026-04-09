output "arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.pub_alb.arn
}

output "name" {
  description = "Name of the Application Load Balancer"
  value       = aws_lb.pub_alb.name
}

output "dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.pub_alb.dns_name
}

output "dns_zone_id" {
  description = "Route53 hosted zone ID of the Application Load Balancer"
  value       = aws_lb.pub_alb.zone_id
}

output "http_listener_arn" {
  description = "ARN of the ALB listener"
  value       = aws_lb_listener.http.arn
}
