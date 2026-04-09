resource "aws_route_table" "public_subnets" {
  count = length(var.azs)

  vpc_id = aws_vpc.main-demo.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) * length(var.azs)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = count.index <= 2 ? element(aws_route_table.public_subnets.*.id, count.index) : element(
    aws_route_table.public_subnets.*.id,
    count.index % length(var.azs),
  )
}
