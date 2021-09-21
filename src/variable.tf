#######   Security groups variables  ######

variable "name" {}
variable "region" {}
variable "description" {}
variable "vpc_id" {}
variable "sg_ingress_rules"{
  type = map
}
variable "sg_egress_rules"{
  type = map
}
variable "tags" {
  type = map
}

#######  Egress rules ######

variable "egress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = []
}

/* variable "security_group_id"{} */


###### Ingress rules ######

variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = []
}







