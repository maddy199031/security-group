module "SecuritytGroup" {
  source = "../src/"
  region              = var.region
  name                = var.sg_name
  description         = var.sg_description
  vpc_id              = var.vpc_id
  ingress_rule        = var.ingress_rule
  egress_rule         = var.egress_rule
  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules
  tags                = var.tags

}


output "output" {
  
    value = module.SecuritytGroup.v_1_0_7
}
