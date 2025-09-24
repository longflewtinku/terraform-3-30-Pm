data "aws_vpc" "myalreadyvpc" {
    default = true
}

data "aws_security_group" "myalreadysg" {
    filter {
      name = "group-name"
      values = ["myjulybatch"]
    }
}
resource "aws_key_pair" "myownkey" {
    public_key = file("~/.ssh/id_ed25519.pub")
    key_name = "julykey"
  
}
data "aws_ami" "myubuntuami" {
    most_recent = true
    owners = ["099720109477"]
    filter {
      name = "name"
      values = ["ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-20250625"]
    }
   
}


resource "aws_instance" "myownec2" {
    ami = data.aws_ami.myubuntuami.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.myownkey.key_name
    vpc_security_group_ids = [ data.aws_security_group.myalreadysg.id ]
    tags = {
        Name = "myownterraformec2"
    }

    
}
resource "null_resource" "mysomechanging" {
    triggers = {
        buid_id = "1.1"
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.myownec2.public_ip
        private_key = file("~/.ssh/id_ed25519")

    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install docker.io -y",
            "sudo apt install nginx -y",
            "sudo apt install openjdk-17-jdk -y"
        ]
      
    }
  
}
