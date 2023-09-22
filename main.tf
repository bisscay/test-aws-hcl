resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags       = local.tags
}

resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  tags                    = local.tags
}

resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets

  vpc_id     = aws_vpc.this.id
  cidr_block = each.value
  tags       = local.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = local.tags
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_security_group" "this" {
  name        = "allow_ssh_http"
  description = "Allow inbound traffic."
  vpc_id      = aws_vpc.this.id
  tags        = local.tags
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"] # Amazon Linux 2
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  tags = local.tags
}

resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnets["${local.nginx_subnet}"].id
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = var.existing_key_name
  user_data              = local.startup_script
  tags                   = local.tags
}
