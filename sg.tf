resource "aws_security_group" "mysg" {
  name   = "myterraformjulysg"
  vpc_id = aws_vpc.myvpcterraform.id
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.mysg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_2" { 
  security_group_id = aws_security_group.mysg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}


   
