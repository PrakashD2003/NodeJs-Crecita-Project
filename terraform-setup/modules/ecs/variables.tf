variable "aws_region" {
  description = "Region Where all resources will be created"
  default = "ap-south-1"
}

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
  default = [ "" ]
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
# }

variable "container_definitions" {
  description = "Full JSON string for container definitions (overrides individual inputs)"
  type        = string
  default     = ""
}


variable "ecs_output_filepath" {
  description = "Path to write out resource metadata for ECS"
  type        = string
  default = "./outputs/ecs_info.json"
}

