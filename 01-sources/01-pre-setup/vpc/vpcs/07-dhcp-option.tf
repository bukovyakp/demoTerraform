resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
}

resource "aws_vpc_dhcp_options_association" "vpc_dhcp_association" {
  depends_on      = [aws_vpc.main-demo]
  vpc_id          = aws_vpc.main-demo.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}
