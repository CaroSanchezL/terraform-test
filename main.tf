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

resource "aws_route_table_association" "rt_ig_association" {
 for_each = { for k, v in aws_subnet.subnet:
               k => v if length(regexall(".*-pub-", v.tags["Name"])) > 0 }

  subnet_id = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

#--------------------------------EIP--------------------------------------#

resource "aws_eip" "Nat-Gateway-EIP" {
  count = 2
  vpc = true

  tags = {
    Name = count.index == 1 ? "nat1" : "nat2"
  }
}

# aws_eip.Nat-Gateway-EIP[0]

resource "aws_nat_gateway" "NAT_GATEWAY" {
  
  for_each = { for k, v in aws_subnet.subnet: 
               k => v if length(regexall(".*-pub-", v.tags["Name"])) > 0 }

  #allocation_id =

  subnet_id = aws_subnet.subnet[each.key].id 

  tags = {
    Name = "Nat-Gateway"
  }
}