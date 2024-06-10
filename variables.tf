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
  # default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  # default     = "10.0.0.0/16"
}
variable "ami" {
  description = "AMI for Amazon LInux 2023"
  type        = string
  default     = "ami-00beae93a2d981137"
}
variable "instance_type" {
  description = "instance type for ec2"
  type        = string
  # default     = "t2.micro"
}
variable "cidr_all" {
  description = "All CIDRs"
  type        = string
  # default     = "0.0.0.0/0"
}
