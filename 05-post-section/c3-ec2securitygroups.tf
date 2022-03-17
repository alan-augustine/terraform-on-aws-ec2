resource "aws_security_group" "vpc-ssh" {
    name = "vpc-ssh"
    ingress {
        description = "Allow SSH from internet"
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        description = "Allow all outbound traffic"
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
      "Name" = "vpc-ssh"
    }
}

resource "aws_security_group" "vpc-web" {
    name = "vpc-web"
    ingress {
        description = "Allow Web from internet"
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        description = "Allow all outbound traffic"
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
      "Name" = "vpc-web"
    }
}