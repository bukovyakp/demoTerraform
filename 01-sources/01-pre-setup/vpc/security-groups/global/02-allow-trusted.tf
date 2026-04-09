resource "aws_security_group" "allow_trusted" {
  vpc_id      = local.dependency.networking.vpc_id
  name        = "${var.environment_name}_allow_trusted"
  description = "Allow all inbound and outgoing traffic inside VPCc"
}

resource "aws_security_group_rule" "allow_all_outgoing" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
  description = "allow_all_outgoing"

  security_group_id = aws_security_group.allow_trusted.id
}

resource "aws_security_group_rule" "allow_all_inbound" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = [local.dependency.networking.vpc_cidr]
  description = "allow_all_inbound"

  security_group_id = aws_security_group.allow_trusted.id
}
