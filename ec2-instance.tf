
resource "aws_instance" "dev_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.public)[0].id
  vpc_security_group_ids = [aws_security_group.dev_server.id]
  key_name               = var.key_name

  user_data            = <<-EOF
              #!/bin/bash
              set -e

              echo "🔧 Updating and installing Docker..."
              apt-get update -y
              apt-get install -y ca-certificates curl gnupg lsb-release

              # Add Docker's official GPG key
              install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              chmod a+r /etc/apt/keyrings/docker.gpg

              # Add the Docker repo
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
                https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              # Install Docker Engine and Compose plugin
              apt-get update -y
              apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

              # Enable and start Docker
              systemctl enable docker
              systemctl start docker

              echo "✅ Docker installed successfully."

              EOF
  iam_instance_profile = aws_iam_instance_profile.ec2_ecr_profile.name
  tags = {
    Name = var.project_name
  }
}