#-------------------------------------VPC--------------------------------------------#

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
      Name = var.vpc_tags_name
    }

}

#-----------------------------------------SUBNETS-----------------------------------------#

resource "aws_subnet" "subnet" {
    count = 4
    
    vpc_id = aws_vpc.main.id
    
    cidr_block = count.index == 1 ? var.subnets[0].cidr_block : count.index == 2 ? var.subnets[1].cidr_block : count.index == 3 ? var.subnets[2].cidr_block :  var.subnets[3].cidr_block
    
    availability_zone = count.index == 1 ? var.subnets[0].availability_zone : count.index == 2 ? var.subnets[1].availability_zone : count.index == 3 ? var.subnets[2].availability_zone : var.subnets[3].availability_zone

    tags = {
      Name = "${count.index == 1 ? var.subnets[0].tag : count.index == 2 ? var.subnets[1].tag : count.index == 3 ? var.subnets[2].tag : var.subnets[3].tag}"
    }
    # for_each = { for x in var.subnets: x.tag => x }
    # vpc_id     = aws_vpc.main.id
    # cidr_block = each.value.cidr_block
    # availability_zone = each.value.availability_zone

    # tags = {
    #     Name = each.value.tag
    # }  

}

#------------------------------------INTERNET GATEWAY-------------------------------·#

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

#-------------------------------------------EIP-----------------------------------------#

resource "aws_eip" "nat_eip" {
  count = 2
  vpc = true

  tags = {
    Name = "${count.index == 1 ? var.eip_name[0] : var.eip_name[1]}"
  }
}

# aws_eip.Nat-Gateway-EIP[0]

resource "aws_nat_gateway" "nat_gateway" {

  count = 2

  allocation_id = count.index == 1 ? aws_eip.nat_eip[0].id : aws_eip.nat_eip[1].id
  
  subnet_id = count.index == 1 ? aws_subnet.subnet[1].id : aws_subnet.subnet[3].id

  # for_each = { for k, v in aws_subnet.subnet: 
  #              k => v if length(regexall(".*-pub-", v.tags["Name"])) > 0 }

  # dynamic "eip" {

  # }

  # subnet_id = aws_subnet.subnet[each.key].id 

  tags = {
    Name = "${count.index == 1 ? var.nat_name[0] : var.nat_name[1]}"
  }
}

#-----------------------------------ROUTE TABLES------------------------------------#

resource "aws_route_table" "subnet_rt" {
  
  count = 3

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = count.index == 1 ? aws_internet_gateway.igw.id : count.index == 2 ? aws_nat_gateway.nat_gateway[0].id : aws_nat_gateway.nat_gateway[1].id
  }

  tags = {
    Name = "${count.index == 1 ? var.rt_name[0] : count.index == 1 ? var.rt_name[1] : var.rt_name[2]}"
  }
}

#----------------------------------ROUTE TABLE ASSOCIATION-----------------------------------#

resource "aws_route_table_association" "rt_association" {

  count = 4

  subnet_id = count.index == 1 ? aws_subnet.subnet[0].id : count.index == 2 ? aws_subnet.subnet[1].id : count.index == 3 ? aws_subnet.subnet[2].id : aws_subnet.subnet[3].id

  route_table_id = count.index == 1 ? aws_route_table.subnet_rt[0].id : count.index == 2 ? aws_route_table.subnet_rt[1].id : count.index == 3 ? aws_route_table.subnet_rt[2].id : aws_route_table.subnet_rt[1].id

}



