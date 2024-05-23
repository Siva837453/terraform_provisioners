resource "aws_instance" "Instance" {

    ami = "ami-090252cbe067a9e58"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-0fdf18ffe954458d7"]
  

    #provisioners will run when are creating resource will created
    #They will not run once the resources are created
    provisioner "local-exec" {
    command = "echo ${self.private_ip} > private_ips.txt"
  }
    
    
#     provisioner "local-exec" {
#     command = "ansible-playbook -i private_ips.txt web.yaml"
#   }


    connection {
      
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo dnf install ansible -y",
            "sudo dnf install nginx -y",
            "sudo dnf systemctl start nginx"
    ]
  }

}





