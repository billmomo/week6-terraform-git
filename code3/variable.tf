variable "region" {
  default = "us-east-1"
}


# vpc variable

variable "vpc_name" {
  default = "my-vpc"
}

variable "cblock" {
    default = "10.0.0.0/16"
  
}

variable "enable_nat_gateway" {
    default = false
  
}

variable "enable_vpn_gateway" {
    default = false
  
}

variable "enable_dns_hostnames" {
    default = true
  
}