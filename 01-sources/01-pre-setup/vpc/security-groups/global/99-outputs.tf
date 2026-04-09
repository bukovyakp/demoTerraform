output "sg_allow_web" {
  description = "Allow web traffic security group id"
  value       = aws_security_group.allow_web.id
}

output "sg_allow_trusted" {
  description = "Allow web traffic security group id"
  value       = aws_security_group.allow_trusted.id
}
