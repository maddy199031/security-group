
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

variable "egress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    # default     = []
    default    = [
      {
        from_port   = 0,
        to_port     = 0,
        protocol    = -1,
        cidr_blocks = ["0.0.0.0/0"],
      }
    ]
}



variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    # default     = []
    default    = [
      {
        from_port   = 22,
        to_port     = 22,
        protocol    = "tcp",
        cidr_blocks = ["10.0.0.0/8"],
      },
      {
        from_port   = 3,
        to_port     = -1,
        protocol    = "icmp",
        cidr_blocks = ["10.0.0.0/8"],
      },
      {
        from_port   = 8,
        to_port     = -1,
        protocol    = "icmp",
        cidr_blocks = ["10.0.0.0/8"],
      },
      {
        from_port   = 11,
        to_port     = -1,
        protocol    = "icmp",
        cidr_blocks = ["10.0.0.0/8"],
      },
    ]
}

