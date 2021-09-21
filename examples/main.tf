module "SecuritytGroup" {
  source = "../src/"
  region              = var.region
  name                = var.sg_name
  description         = var.sg_description
  vpc_id              = var.vpc_id
  sg_ingress_rules    = var.sg_ingress_rules
  sg_egress_rules     = var.sg_egress_rules
  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules
  tags                = var.sg_tags

}


output "outputs" {
  
    value = {
        security_group_id = module.SecuritytGroup.security_group_id
        sg_egress_rules_id= module.SecuritytGroup.sg_egress_rules_id
        sg_ingress_rules_id = module.SecuritytGroup.sg_ingress_rules_id

    }
}
