resource "aws_security_group" "allow_web" {
  vpc_id      = local.dependency.networking.vpc_id
  name        = "${var.environment_name}_allow_web"
  description = "Allow web - HTTP(S) - inbound traffic and all outband traffic"
}

resource "aws_security_group_rule" "allow_all_outgoing_web" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow_all_outgoing"

  security_group_id = aws_security_group.allow_web.id
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow_http_inbound"

  security_group_id = aws_security_group.allow_web.id
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow_https_inbound"

  security_group_id = aws_security_group.allow_web.id
}
