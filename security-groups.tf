# Modern Security Group setup (AWS Provider v5+)
resource "aws_security_group" "dev_server" {
  name        = "${var.project_name}-sg"
  description = "Security group for dev server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow SSH"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allow_ssh_from[0]
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow HTTP"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow HTTPS"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "dev_ports" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow common dev ports"
  from_port         = 3000
  to_port           = 9000
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_pg_access" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow pg access"
  from_port         = 4352
  to_port           = 4352
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allow_ssh_from[0]
}

# --- Egress Rule ---
resource "aws_vpc_security_group_egress_rule" "all_out" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow all outbound traffic"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# SSH for GitHub Actions
resource "aws_vpc_security_group_ingress_rule" "ssh_github" {
  security_group_id = aws_security_group.dev_server.id
  description       = "Allow SSH from GitHub Actions runners"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "140.82.0.0/16"
}