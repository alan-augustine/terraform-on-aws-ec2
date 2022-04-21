resource "null_resource" "name" {
    depends_on = [module.ec2_public]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_eip.bastion_eip.public_ip  
    private_key	= file("/home/user1/terraform-key.pem")
  }

  # File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
      source      = "/home/user1/terraform-key.pem"
      destination = "/tmp/terraform-key.pem"
    
  }

  provisioner "remote-exec" {
      inline = [ "sudo chmod 400 /tmp/terraform-key.pem"]
  }

## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
  
## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
/*  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  }  
  */

}

# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)

