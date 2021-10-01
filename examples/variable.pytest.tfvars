region = "us-east-2"


name= "security_group_name_module"
description= "sg_description_module"
vpc_id= "vpc-0c53ca67"


ingress_rule = {
        ingress_from_port  = 22
        ingress_to_port    = 22
        ingress_protocol   = "tcp"
        access_ip          = "0.0.0.0/0"
}


egress_rule = {
        egress_from_port   = 0
        egress_to_port     = 0
        egress_protocol    = -1
        access_ip          = "0.0.0.0/0"
}

tags = {
  "origin" : "terraform",
  "owner" : "teratest - automated tests",
  "tenant" : "syncron-op",
  "cost_category" : "internal-product",
  "environmenttype" : "dev",
  "product" : "op",
  "gerrit" : "op/terraform/modules/security-group ",
  "branch" : "master",
  "path" : "examples/TestBaseSGModule",
  "JIRA" : "BDCO-289",
  "Name" : "security-group"
}



ingress_rules    = [
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = "4.2.2.1/32"
          description = "ingress_rules"
        },
        {
          from_port   = 24
          to_port     = 24
          protocol    = "tcp"
          cidr_block  = "4.2.2.1/33"
          description = "ingress_rules"
        }        

    ]

egress_rules    = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "tcp"
          cidr_block  = "4.5.6.4/32"
          description = "egress_rules"
        }
    ]
