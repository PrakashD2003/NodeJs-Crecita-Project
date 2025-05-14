data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
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

module "ecr" {
  source               = "../modules/ecr"
  ecr_repository_name  = var.ecr_repository_name
  image_tag_mutability = var.image_tag_mutability
  lifecycle_policy     = var.lifecycle_policy
  ecr_tags             = var.ecr_tags
  output_file          = var.output_file
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"                   # Principal type
      identifiers = ["ecs-tasks.amazonaws.com"] # ECS will assume this role
    }

    actions = ["sts:AssumeRole"] # Action allowed
  }
}

module "ecs_execution_role" {
  source = "../modules/iam_role"

  role_name          = var.role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  iam_role_tags = var.iam_role_tags
}


module "ecs" {
  source             = "../modules/ecs"
  cluster_name       = var.cluster_name
  container_name     = var.container_name
  container_image    = var.container_image
  port               = var.port
  task_family        = var.task_family
  cpu                = var.cpu
  memory             = var.memory
  execution_role_arn = module.ecs_execution_role.role_arn
  service_name       = var.service_name
  desired_count      = var.desired_count
  subnets            = data.aws_subnets.all.ids
  security_groups    = [module.security_group.security_group_id]
}
