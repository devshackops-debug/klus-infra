output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "nat_gateway_ip" {
  value = aws_eip.nat.public_ip
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}


output "ecr_backend_repo_url" {
  description = "ECR repository URL for backend images"
  value       = aws_ecr_repository.backend.repository_url
}

output "ecr_frontend_repo_url" {
  description = "ECR repository URL for frontend images"
  value       = aws_ecr_repository.frontend.repository_url
}

output "server_id" {
  value       = aws_instance.dev_server.public_ip
  description = "Server public ip address"
}