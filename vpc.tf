################################################################################
# VPC Subnetting
################################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc.name
  cidr = local.vpc.cidr

  azs             = local.vpc.azs
  private_subnets = local.vpc.subnets.private
  public_subnets  = local.vpc.subnets.public

  enable_vpn_gateway = false

  # Single NAT Gateway
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    ManagedBy   = "diego.jaureugi@jala.university"
  }
}
################################################################################
# Security group
################################################################################
module "vpc_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = local.vpc.sg.name
  description = local.vpc.sg.description
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]
}
