################################################################################
# EC2 Instances
################################################################################
# Private Subnet Instances
module "ec2_private_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  count   = length(local.vpc.subnets.private)

  depends_on = [
    module.vpc
  ]

  name = "${local.ec2.name}-priv-${count.index}"

  ami           = local.ec2.ami
  instance_type = local.ec2.instance_type
  monitoring    = false
  subnet_id     = module.vpc.private_subnets[count.index]

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
    module.vpc
  ]

  name = "${local.ec2.name}-pub-${count.index}"

  ami           = local.ec2.ami
  instance_type = local.ec2.instance_type
  monitoring    = false
  subnet_id     = module.vpc.public_subnets[count.index]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    ManagedBy   = "diego.jaureugi@jala.university"
  }
}