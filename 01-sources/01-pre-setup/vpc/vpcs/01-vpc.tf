resource "aws_vpc" "main-demo" {
  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-demo"
  }
}
