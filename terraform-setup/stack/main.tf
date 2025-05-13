data "aws_vpc" "default" {
  default = true
}

module "security_group" {
  source         = "../modules/security_group"
  sg_name        = var.sg_name
  sg_description = var.sg_description
  vpc_id         = data.aws_vpc.default.id
  ingress_rules  = var.ingress_rules
  egress_rules   = var.egress_rules
  sg_output_file = var.sg_output_file
  sg_tags        = var.sg_tags
}

module "ec2" {
  source             = "../modules/ec2"
  instance_name      = var.instance_name
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  key_name           = var.key_name
  subnet_id          = var.subnet_id
  security_group_ids = [module.security_group.security_group_id]
  ec2_output_file    = var.ec2_output_file
  ec2_tags           = var.ec2_tags
}