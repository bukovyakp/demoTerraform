output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main-demo.id
}

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.main-demo.arn
}

output "vpc_name" {
  description = "The name of the VPC."
  value       = var.name
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC."
  value       = var.cidr
}

output "vpc_azs" {
  description = "The availability zones for the VPC."
  value       = var.azs
}

output "public_subnets" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public.*.id
}
