variable "aws_region" {
    description = "AWS Region"
}
variable "aws_access_key" {
    description = "AWS Access Key"
}
variable "aws_secret_key" {
    description = "AWS Secret Key"
}


variable "vpc_cidr_block" {
    description = "VPC CIDR Block"
}
variable "subnet_cidr_block" {
    description = "Subnet CIDR Block"
}
variable "whitelist" {
    description = "Whitelist IP"
}


variable "web_image_id" {
    description = "Web Image ID"
}
variable "web_instance_type" {
    description = "Web Instance Type"
}
variable "web_key_name" {
    description = "Web Key Name"
}
variable "web_key_file" {
    description = "Web Key File"
}