resource "aws_subnet" "public" {
  count      = length(var.public_subnets) * length(var.azs)
  vpc_id     = aws_vpc.main-demo.id
  cidr_block = element(
    concat(
      var.public_subnet_cidr.demo_public,
    ),
    count.index,
  )
  availability_zone = count.index <= 2 ? element(var.azs, count.index) : element(var.azs, count.index % length(var.azs))
}
