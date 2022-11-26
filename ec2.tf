################################################################################
# EC2 Instances
################################################################################
# Security Group
module "sg_ec2_net" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2_net_sg"
  description = "Security "
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  ingress_rules       = ["all-icmp", "ssh-tcp"]
  egress_rules        = ["all-icmp", "ssh-tcp"]
}
# Private Subnet Instances
module "ec2_private_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  count   = length(local.vpc.subnets.private)

  depends_on = [
    module.vpc, module.sg_ec2_net
  ]

  name = "${local.ec2.name}-priv-${count.index}"

  ami           = local.ec2.ami
  instance_type = local.ec2.instance_type
  monitoring    = false
  subnet_id     = module.vpc.private_subnets[count.index]

  vpc_security_group_ids = tolist([module.sg_ec2_net.security_group_id])
  tags = {
    Terraform   = "true"
    Environment = "dev"
    ManagedBy   = "diego.jaureugi@jala.university"
  }
}
#Public subnet Instance
module "ec2_public_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  count   = length(local.vpc.subnets.public)

  depends_on = [
    module.vpc, module.sg_ec2_net
  ]

  name = "${local.ec2.name}-pub-${count.index}"

  ami           = local.ec2.ami
  instance_type = local.ec2.instance_type
  monitoring    = false
  subnet_id     = module.vpc.public_subnets[count.index]

  vpc_security_group_ids = tolist([module.sg_ec2_net.security_group_id])
  tags = {
    Terraform   = "true"
    Environment = "dev"
    ManagedBy   = "diego.jaureugi@jala.university"
  }
}