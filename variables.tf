variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "af-south-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Project name prefix for tagging"
  type        = string
  default     = "klus-dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones for deployment"
  type        = list(string)
  default     = ["af-south-1a", "af-south-1b"]
}

# --- Ingress Rules ---
variable "allow_ssh_from" {
  type    = list(string)
  default = [""]
}
variable "key_name" {
  default = "psg-key-public"
}

variable "instance_type" {
  default = "t3.medium"
}
variable "ami_id" {
  default = "ami-00578e5c7b5d64f2a"
}