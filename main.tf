resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
      Name = var.vpc_tags_name
    }

}

resource "aws_subnet" "subnet" {
# count = 2

#   vpc_id     = aws_vpc.main.id
#   cidr_block = "${count.index == 1 ? "10.0.0.0/25" : "10.0.0.128/25"}"
#   availability_zone = "${count.index == 1 ? "us-east-2a" : "us-east-2b"}"

#   tags = {
#     Name = "${count.index == 1 ? "pub" : "pri"}"
#   }

    for_each = { for x in var.subnets: x.tag => x }
    vpc_id     = aws_vpc.main.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone

    tags = {
        Name = each.value.tag
    }  

}