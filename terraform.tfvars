aws_region         = "us-east-1"
aws_access_key     = ""     
aws_secret_key     = ""

vpc_cidr_block     = "10.0.0.0/16"
subnet_cidr_block  = "10.0.1.0/24"
whitelist          = ["0.0.0.0/0"]

web_image_id       = "ami-0ff8a91507f77f867" # Amazon Linux 2 AMI 
web_instance_type  = "t3a.micro"
web_key_name       = "webserver_key"
web_key_file       = "webserver_key.pem"