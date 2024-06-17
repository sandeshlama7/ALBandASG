variable "subnets-conf" {
  description = "CIDR for Subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "public-subnet-1a" = {
      cidr = "10.0.0.0/22"
      az   = "us-east-1a"
    }
    "public-subnet-1b" = {
      cidr = "10.0.8.0/22"
      az   = "us-east-1b"
    }
  }
}
variable "region" {
  description = "Region"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}
variable "ami" {
  description = "AMI of EC2 instance"
  type        = string
  default     = "ami-04b70fa74e45c3917" #Ubuntu 24.04
}
variable "instance_type" {
  description = "instance type for ec2"
  type        = string
}
variable "cidr_all" {
  description = "All CIDRs"
  type        = string
}
