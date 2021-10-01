module "SecuritytGroup" {
  source = "../src/"
  region              = var.region
  name                = var.name
  description         = var.description
  vpc_id              = var.vpc_id
  ingress_rule        = var.ingress_rule
  egress_rule         = var.egress_rule
  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules
  tags                = var.tags

}


output "outputs" {
  
    value = module.SecuritytGroup.v_1_0_0
}
