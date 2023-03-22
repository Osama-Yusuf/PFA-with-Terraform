# Public Facing Application (WebApp) with Terraform

This Terraform code creates the infrastructure for a simple web application on AWS.

## Resources Created

1. *VPC*: Creates a Virtual Private Cloud (VPC) named `simple-web-app-vpc`.
2. *Internet Gateway*: Creates an Internet Gateway named `Web-IGW` and attaches it to the VPC.
3. *Route Table*: Creates a public route table named `Public Route Table` and adds a default route pointing to the Internet Gateway.
4. *Subnet*: Creates a public subnet named `webserver-subnet` in the VPC and associates it with the public route table.
5. *Security Group*: Creates a security group named `webserver-sg` with rules for allowing SSH, HTTP, and HTTPS traffic.
6. *Key Pair*: Generates an RSA key pair named `webserver_key` and saves the private key to a local file.
7. *EC2 Instance*: Creates an EC2 instance named `webserver_instance` in the public subnet and attaches the security group and key pair.

## Usage Instructions

1. Clone this repository to your local machine.
2. Terraform init
3. Terraform plan
4. Terraform apply
5. Terraform destroy
