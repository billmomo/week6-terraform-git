provider "aws" {
  region = "us-east-3"

}

# create vpc 
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bless-vpc"
  cidr = "192.168.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24"]
  public_subnets  = ["192.168.101.0/24", "192.168.102.0/24"]

#   enable_nat_gateway = false
#   enable_vpn_gateway = false

  enable_dns_hostnames = true


  tags = {
    name : "utc-app1"
    env : "dev"
    team : "wdp"
    created-by : "momo"
  
  }
} 



# security group 


resource "aws_security_group" "sg" {
  name        = "webserver-sg"
  description = "allow traffic on 22 and 80"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "22 for ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }
   ingress {
    description      = "80 for http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "webserver-sg"
    Team = "Devops"
    owner = "serge"
  }
}
  
# Generate a secure key using a rsa algorithm
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# creating the keypair in aws
resource "aws_key_pair" "ec2_key" {
  key_name   = "terraform-key19"                 
  public_key = tls_private_key.ec2_key.public_key_openssh 
}

# Save the .pem file locally for remote connection
resource "local_file" "ssh_key" {
  filename = "terraform.pem"
  content  = tls_private_key.ec2_key.private_key_pem
}




# creating the keypair in aws
resource "aws_key_pair" "ec2_key11" {
  key_name   = "terraform-ke111"                 
  public_key = tls_private_key.ec2_key.public_key_openssh 
}

# Save the .pem file locally for remote connection
resource "local_file" "ssh_key1" {
  filename = "terraform.pem"
  content  = tls_private_key.ec2_key.private_key_pem
}

# create the ec2 instance
resource "aws_instance" "server" {
  ami           = "ami-06c473c47d0038f47"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name = "Terraform-ec2-instance"
    Env  = "dev"
  }
}

output "ec2_ip" {
 value =  aws_instance.server.public_ip
}

output "dns_name" {
 value = aws_instance.server.public_dns 
}

output "vpcid" {
 value = module.vpc.vpc_id 
}