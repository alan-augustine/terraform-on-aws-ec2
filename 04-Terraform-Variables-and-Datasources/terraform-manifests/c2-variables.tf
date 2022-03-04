variable "aws_region" {
    type = string
    description = "AWS Region"
    default = "us-east-1"
}

variable "instance_type" {
    type = string
    description = "EC2 instance type"
    default = "t2.micro"
}

variable "instance_keypair" {
    type = string
    description = "AWS EC2 key pair"
    default = "terraform-key"
}

