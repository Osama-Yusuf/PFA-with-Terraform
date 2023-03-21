provider "aws" {
  region     = var.aws_region 
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# A VPC named simple-web-app
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "simple-web-app-vpc"
  }
}

# An internet gateway named Web-IGW
resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Web-IGW"
  }
}

# A public route table named Public Route Table with the public subnet attached to it
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# A public subnet named webserver-subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "webserver-subnet"
  }
}

# A security group named webserver_sg with ssh, http and https ports open
resource "aws_security_group" "webserver_sg" {
  name        = "webserver-sg"
  description = "SG for Webserver"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    # to manage the instance
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }
  ingress {
    # to access the PFA through the http
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }
  ingress {
    # to access the PFA through the https
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }
}

# Create a key pair named webserver_key in order to access the instance
resource "aws_key_pair" "webserver_key" {
  key_name   = var.web_key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

# Create a private key
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key to a file
resource "local_file" "webserver_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.web_key_file
}

# A webserver instance named webserver in public subnet with the security group and key pair attached
resource "aws_instance" "webserver_instance" {
  ami           = var.web_image_id 
  instance_type = var.web_instance_type
  key_name      = var.web_key_name

  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  subnet_id              = aws_subnet.public_subnet.id

  tags = {
    Name = "webserver_instance"
  }
}