variable "aws_region" {
  description = "Region where all resources will be created"
  default     = "ap-south-1"
}

### SECURITY GROUP VARIABLES ###
variable "sg_name" {
  description = "Name for the SG"
  type        = string
}
variable "sg_description" {
  description = "SG description"
  type        = string
  default     = "managed by Terraform"
}
variable "vpc_id" {
  description = "ID of the VPC to attach SG to"
  type        = string
  default     = ""
}

# simple 1-rule example; you can expand this to lists of maps
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}

variable "sg_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "sg_output_file" {
  description = "Path to write out resource metadata for CI/CD"
  type        = string
  default     = "./outputs/sg_info.json"
}


### EC2 VARIABLES ###
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be launched"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = [""]
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "ec2_tags" {
  description = "Additional tags for EC2"
  type        = map(string)
  default     = {}
}

variable "iam_instance_profile" {
  description = "Name of the IAM Instance Profile to attach to this EC2 (optional)"
  type        = string
  default     = null
}

# where to write the output file
variable "ec2_output_file" {
  description = "Path to write out resource metadata for CI/CD"
  type        = string
  default     = "./outputs/ecr_info.json"
}

### ECR Variables ###
variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "vehicle-insurance-project-repo"
}

variable "image_tag_mutability" {
  description = "Whether the image tag is mutable or immutable"
  type        = string
  default     = "MUTABLE" # mutable or true for immutable
}

variable "lifecycle_policy" {
  description = "Lifecycle policy for the ECR repository"
  type        = string
  default     = null
}

variable "ecr_tags" {
  description = "A map of tags to assign to the ECR repository"
  type        = map(string)
  default     = {}

}

# where to write the output file
variable "output_file" {
  description = "Path to write out resource metadata for CI/CD"
  type        = string
  default     = "./infrastructure/outputs/ecr_info.json"
}


### ECS Variables ###
variable "cluster_name" {
  description = "Name for the ECS cluster"
  type        = string
}

variable "service_name" {
  description = "Name for the ECS service"
  type        = string
}

variable "task_family" {
  description = "Family name for the task definition"
  type        = string
}

variable "container_name" {
  description = "Name of the container inside the task"
  type        = string
}

variable "container_image" {
  description = "Docker image URI (from ECR)"
  type        = string
}

variable "cpu" {
  description = "CPU units for the task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (MiB) for the task"
  type        = number
  default     = 512
}

variable "port" {
  description = "Container port to expose"
  type        = number
  default     = 3000
}

variable "desired_count" {
  description = "Desired number of task replicas"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "List of subnet IDs for service networking"
  type        = list(string)
  default     = [""]
}

variable "security_groups" {
  description = "List of security group IDs for service networking"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign public IP to Fargate tasks"
  type        = bool
  default     = true
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
}

# variable "task_role_arn" {
#   description = "IAM role ARN for ECS task runtime permissions"
#   type        = string
#   default     = ""
# }

variable "container_definitions" {
  description = "Full JSON string for container definitions (overrides individual inputs)"
  type        = string
  default     = ""
}

variable "ecs_output_filepath" {
  description = "Path to write out resource metadata for ECS"
  type        = string
  default     = "./outputs/ecs_info.json"
}


### I_AM_ROLE Variables ###
variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
}

variable "assume_role_policy" {
  description = "The JSON policy that grants an entity permission to assume the role"
  type        = string
  default = ""
}

variable "managed_policy_arns" {
  description = "List of IAM managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = <<EOF
Map of inline policies to attach.  
Key   = policy name  
Value = JSON policy document  
EOF
  type        = map(string)
  default     = {}
}

variable "iam_role_tags" {
  description = "Tags to apply to the IAM role"
  type        = map(string)
  default     = {}
}

# where to write the output file
variable "iam_role_output_file" {
  description = "If non-null, write this role’s metadata (name, id, arn, tags) to this JSON file"
  type        = string
  default     = null
}
