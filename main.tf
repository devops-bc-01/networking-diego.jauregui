terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}

################################################################################
# Locals Variables
################################################################################
locals {
  vpc = {
    name = "networking_diego_jauregui"
    cidr = "192.168.0.0/20"
    azs  = ["us-east-1a"]
    sg = { # Security Group
      name        = "sg_vpc_net_diego_jauregui"
      description = "Security Group rules for Private Connection"
    }
    subnets = { # Subnets of Blocks
      # Office 1 (500 H)  Office 2 (80 H)   Office 3 (40 H)
      private = ["192.168.0.0/23", "192.168.2.0/25", "192.168.2.128/26"]
      # Remote Office (20 H)
      public = ["192.168.2.192/27"]
    }
  }

  ec2 = { # Instance variables
    name          = "ec2_net_diego_jauregui"
    instance_type = "t2.micro"
    ami           = "ami-0b0dcb5067f052a63" # Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2
  }
}
