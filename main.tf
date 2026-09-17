module "vpc" {
  source               = "./modules/vpc"
  name_prefix          = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  availability_zone    = var.availability_zone
  availability_zone_b  = var.availability_zone_b
  public_subnet_cidr_b = var.public_subnet_cidr_b
}

module "alb" {
  source            = "./modules/alb"
  name_prefix       = var.name_prefix
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_b]
}

module "ec2" {
  source                = "./modules/ec2"
  name_prefix           = var.name_prefix
  instance_type         = var.instance_type
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_b]
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
}