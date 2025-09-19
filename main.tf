
resource "aws_vpc" "myvpcterraform" {
  cidr_block = var.net_info.vpccidr
  tags = {
    Name = var.net_info.vpcname
  }
}
resource "aws_subnet" "publicsubnets" {
  count             = local.public_subnets
  vpc_id            = aws_vpc.myvpcterraform.id
  cidr_block        = var.net_info.pub_sub_info[0].pubsubcidrs[count.index]
  availability_zone = var.net_info.pub_sub_info[0].pubsubazs[count.index]
  tags = {
    Name = var.net_info.pub_sub_info[0].pubsubnames[count.index]
  }
  depends_on = [ aws_vpc.myvpcterraform ]
}
resource "aws_subnet" "privatesubnets" {
  count = length(var.net_info.pr_sub_info[0].prcidrs)
  vpc_id = aws_vpc.myvpcterraform.id
  cidr_block = var.net_info.pr_sub_info[0].prcidrs[count.index]
  availability_zone = var.net_info.pr_sub_info[0].prazs[count.index]
  tags = {
    Name = var.net_info.pr_sub_info[0].prsubnames[count.index]
  }
  depends_on = [ aws_vpc.myvpcterraform,
                 aws_subnet.publicsubnets ]
  
}
resource "aws_route_table" "myownroute" {
  vpc_id = aws_vpc.myvpcterraform.id
  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "routetablemy"
  }
  depends_on = [ aws_vpc.myvpcterraform ]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpcterraform.id
  tags = {
    Name = "myigw"
  }
  
}
resource "aws_route_table_association" "publicroute" {
  count = local.public_subnets
  route_table_id = aws_route_table.myownroute.id
  subnet_id = aws_subnet.publicsubnets[count.index].id
  depends_on = [ aws_subnet.publicsubnets ]
}