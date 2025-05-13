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
  default = [ "" ]
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

