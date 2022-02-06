#-------------------------------------VPC--------------------------------------------#

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
      Name = var.vpc_tags_name
    }

}

#------------------------------------SUBNETS-----------------------------------------#

resource "aws_subnet" "subnet" {

    for_each = { for x in var.subnets: x.tag => x }
    vpc_id     = aws_vpc.main.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone

    tags = {
        Name = each.value.tag
    }  

}

#------------------------------------INTERNET GATEWAY-------------------------------·#

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

#-----------------------------------ROUTE TABLES------------------------------------#

resource "aws_route_table" "Public-Subnet-RT" {
  

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt_pub"
  }
}

#------------------------------ROUTE TABLE ASSOCIATION-----------------------------------#

resource "aws_route_table_association" "RT-IG-Association" {

count = 2

  subnet_id = count.index == 0 : aws_subnet.subnets[0].id
  

  #como asociar dos subnets en un list(map)

#  Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

# como crear y alocar (?) un Elastic IP a una NAT