variable "region" {
    default = "us-east-2"
}

variable "sg_name" {
  type = string
  default= "security_group_name_module"
}
variable "sg_description" {
  type = string
  default= "sg_description_module"
}

variable "vpc_id" {
  description = "A list of subnet IDs to attach to the ELB"
  default= "vpc-0c53ca67"
}

variable "ingress_rule"{
  type = map
  default = {
        ingress_from_port  = 22
        ingress_to_port    = 22
        ingress_protocol   = "tcp"
        access_ip          = "0.0.0.0/0"
}
}

variable "egress_rule"{
  type = map
  default = {
        egress_from_port   = 0
        egress_to_port     = 0
        egress_protocol    = -1
        access_ip          = "0.0.0.0/0"
}
}


variable "tags" {
  type    = map(string)
  default = {}
}



variable "ingress_rules" {
    default     = [
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = "4.2.2.1/32"
          description = "ingress_rules1"
        }     
    ]
}


variable "egress_rules" {

    default     = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "tcp"
          cidr_block  = "4.5.6.4/32"
          description = "egress_rules1"
        }
    ]
}