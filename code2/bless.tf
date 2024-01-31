resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cblock
  tags = {
  name = var.vpc_name

  }

} 