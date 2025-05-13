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
sg_output_file = "./outputs/sg_info.json"
sg_tags = {
  "name"        = "NodeJs-Project-Security-Group"
  "Environment" = "Dev"
  "Project"     = "NodeJs-Crecita-Project"
  "Owner"       = "Prakash" # Replace with your name or team name
  "Role"        = "NodeJS-app-Deployment"
}


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


