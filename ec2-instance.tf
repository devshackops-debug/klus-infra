
resource "aws_instance" "dev_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.public)[0].id
  vpc_security_group_ids = [aws_security_group.dev_server.id]
  key_name               = var.key_name

  user_data                   = <<-EOF
              #!/bin/bash
              set -e

              echo "🔧 Updating and installing Docker..."
              apt-get update -y
              # 1️⃣ Remove any old or broken docker packages
              sudo apt-get remove -y docker docker-engine docker.io containerd runc docker-compose

              # 2️⃣ Update apt and install prerequisites
              sudo apt-get update -y
              sudo apt-get install -y ca-certificates curl gnupg lsb-release

              # 3️⃣ Add Docker’s official GPG key
              sudo install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              sudo chmod a+r /etc/apt/keyrings/docker.gpg

              # 4️⃣ Add the Docker apt repository
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
                https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

              # 5️⃣ Update apt again so it sees Docker’s repo
              sudo apt-get update -y

              # 6️⃣ Install Docker Engine, CLI, and Compose plugin
              sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


              systemctl enable docker
              systemctl start docker

              echo "✅ Docker installed successfully."

              EOF
  iam_instance_profile        = aws_iam_instance_profile.ec2_ecr_profile.name
  associate_public_ip_address = true
  tags = {
    Name = var.project_name
  }
}
