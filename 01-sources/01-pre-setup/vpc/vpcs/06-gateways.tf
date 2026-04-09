resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main-demo.id
}

resource "aws_route" "public_internet_gateway" {
  count      = length(var.azs)
  depends_on = [
    aws_route_table.public_subnets
  ]
  route_table_id         = element(aws_route_table.public_subnets.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}
