module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cblock

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24"]
  public_subnets  = ["192.168.101.0/24", "192.168.102.0/24"]

#   enable_nat_gateway = var.enable_nat_gateway
#   enable_vpn_gateway = var.enable_vpn_gateway

  enable_dns_hostnames = var.enable_dns_hostnames


  tags = {
    name : "utc-app1"
    env : "dev"
    team : "wdp"
    created-by : "momo"
  
  }
}
