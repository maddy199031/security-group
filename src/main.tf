resource "aws_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id       = var.vpc_id

  ingress {
    from_port   = lookup(var.ingress_rule,"ingress_from_port")
    to_port     = lookup(var.ingress_rule,"ingress_to_port")
    protocol    = lookup(var.ingress_rule,"ingress_protocol")
    cidr_blocks = [lookup(var.ingress_rule,"access_ip")]
  }

  egress {
    from_port   = lookup(var.egress_rule,"egress_from_port")
    to_port     = lookup(var.egress_rule,"egress_from_port")
    protocol    = lookup(var.egress_rule,"egress_protocol")
    cidr_blocks = [lookup(var.egress_rule,"access_ip")]
  }
  tags                       = var.tags
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.sg.id
}


resource "aws_security_group_rule" "egress_rules" {
  count = length(var.egress_rules)

  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = [var.egress_rules[count.index].cidr_block]
  description       = var.egress_rules[count.index].description
  security_group_id = aws_security_group.sg.id
}

