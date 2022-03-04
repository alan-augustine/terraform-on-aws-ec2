resource "aws_instance" "myec2vm" {
    ami = data.aws_ami.amzlinux2.id
    instance_type = var.instance_type
    user_data = file("${path.module}/app1-install.sh")
    key_name = var.instance_keypair
    security_groups = [ aws_security_group.vpc-ssh.name , aws_security_group.vpc-web.name ]
    tags = {
        Name = "Hello World"
    }
  
}