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
      values = ["ubuntu-pro-server/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-pro-server-20250819"]
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
