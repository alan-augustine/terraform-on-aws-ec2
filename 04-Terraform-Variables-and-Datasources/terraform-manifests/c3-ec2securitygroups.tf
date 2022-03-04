resource "aws_security_group" "vpc-ssh" {
    name = "vpc-ssh"
    description = "SSH SG in default VPC"
    ingress {
        description = "SSH from Internet"
        from_port   = 22
        to_port     = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
         Name = "vpc-ssh"
    }
}

resource "aws_security_group" "vpc-web" {
    name = "vpc-web"
    description = "HTTP SG in default VPC"
    ingress {
        description = "HTTP from Internet"
        from_port   = 80
        to_port     = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
         Name = "vpc-web"
    }
}