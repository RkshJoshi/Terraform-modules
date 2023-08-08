# Common variables

variable "envName" {
  type = string
  default = ""
  description = "Provide the environment name"
}

variable "vpcId"{
  type = string
  description = "Provide the VPCID to deploy"
}

variable "publicSubnets"{
  type = list(string)
  description = "List the public subnets"
  }

variable "privateSubnets"{
  type = list(string)
  description = "List the private subnets"
}

variable "restrictedSubnets"{
  type = list(string)
  description = "list of the restricted subnets to deploy database"
}
