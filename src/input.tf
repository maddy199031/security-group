#######   Security groups variables  ######

variable "name" {}
variable "region" {}
variable "description" {}
variable "vpc_id" {}
variable "ingress_rule"{
  type = map
}
variable "egress_rule"{
  type = map
}
variable "tags" {
  type    = map(string)
  default = {}
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
