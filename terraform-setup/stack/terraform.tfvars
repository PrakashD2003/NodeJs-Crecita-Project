### SG Variables ###
sg_name = "nodeJs-project-sg"
ingress_rules = [{
  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
]
sg_description = "Nodejs-project security-group"
sg_tags = {
  "name"        = "NodeJs-Project-Security-Group"
  "Environment" = "Dev"
  "Project"     = "NodeJs-Crecita-Project"
  "Owner"       = "Prakash" # Replace with your name or team name
  "Role"        = "NodeJS-app-Deployment"
}
sg_output_file = "./outputs/sg_info.json"


### EC2 Variables ###
instance_name = "nodejs-ec2"
instance_type = "t2.micro"
ami_id        = "ami-082a662d6297ab2a2"
key_name      = "NodeJs-Crecita-Project-Key" # Key pair name for SSH access to the EC2 instance (replace with your key pair name).
# security_group_ids = ["sg-0b4c509ac870f99f7"]               # Security group IDs to associate with the EC2 instance (replace with your security group IDs).

ec2_tags = {
  "name"        = "NodeJs-Crecita-Project-Key-instance"
  "Environment" = "Dev"
  "Project"     = "NodeJs-Crecita-Project"
  "Owner"       = "Prakash"
  "Role"        = "NodeJs-App-Deployment"
}
ec2_output_file = "./outputs/ec2_info.json"

### ECR Variables ###
ecr_repository_name  = "nodejs-crecita-repo"
image_tag_mutability = "MUTABLE"
lifecycle_policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 30 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 30
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF 
ecr_tags = {
  "Name"        = "NodeJs-Crecita-Repo"
  "Environment" = "Dev"
  "Project"     = "NodeJs-App-Deployment"
  "Owner"       = "Prakash" # Replace with your name or team name
}
output_file = "./outputs/ecr_info.json" # Path to write out resource metadata for CI/CD

### ECS Variables ###
cluster_name    = "crecita-cluster"
service_name    = "crecita-service"
task_family     = "crecita-task"
container_name  = "crecita-app"
container_image = "519880288079.dkr.ecr.ap-south-1.amazonaws.com/nodejs-crecita-repo:nodejs-crecita-app"
container_definitions = "value"
cpu           = 256
memory        = 512
port          = 3000
desired_count = 1

subnets = [
  "subnet-0abc1234def567890",
  "subnet-0def1234abc567890"
]

security_groups = [
  "sg-0312f6775a8b810cf"
]

assign_public_ip = true
ecs_output_filepath = "./outputs/ecs_info.json"


### I_AM_ROLE Variables ###
role_name = "ecsTaskExecutionRole"
managed_policy_arns = [ "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
iam_role_tags = {
    Project = "Crecita"
  }
