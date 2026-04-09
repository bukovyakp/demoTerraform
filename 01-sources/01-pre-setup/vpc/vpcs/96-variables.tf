variable "name" {
  description = "Name to be used on all the resources as identifier"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "public_subnets" {
  description = "A list of names public subnets inside the VPC"
  type        = list
  default     = []
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list
  default     = []
}

variable "public_subnet_cidr" {
  type = map(list(string))
}
