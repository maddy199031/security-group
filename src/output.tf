

output "v_1_0_7" {
  
    value = {
        security_group_id = aws_security_group.sg.id
        sg_egress_rules_id= aws_security_group_rule.egress_rules.*.id
        sg_ingress_rules_id = aws_security_group_rule.ingress_rules.*.id
    }
}
