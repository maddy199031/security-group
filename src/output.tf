output "security_group_id" {
  value = aws_security_group.sg.id
}
output "sg_egress_rules_id" {
  value = aws_security_group_rule.egress_rules.*.id
}
output "sg_ingress_rules_id" {
  value = aws_security_group_rule.ingress_rules.*.id
}
