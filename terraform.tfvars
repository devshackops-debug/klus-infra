aws_region         = "af-south-1"
aws_profile        = "default"
project_name       = "fast-umsebenzi-dev"
vpc_cidr           = "172.24.0.0/16"
public_subnets     = ["172.24.1.0/24", "172.24.2.0/24"]
private_subnets    = ["172.24.3.0/24", "172.24.4.0/24"]
availability_zones = ["af-south-1a", "af-south-1b"]
allow_ssh_from     = ["105.246.20.54/32"]
