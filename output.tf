output "vpcid" {
    value = data.aws_vpc.myalreadyvpc.id
  
}
output "ec2publicip" {
    value = aws_instance.myownec2.public_ip
  
}
output "urlnginx" {
    value = "http://${aws_instance.myownec2.public_ip}:80"
  
}
