#-------------------------------------VPC--------------------------------------------#
variable "vpc_tags_name" {
    default = "team-4-cs"
}

variable "cidr_block" {}

#------------------------------------SUBNETS-----------------------------------------#

variable "subnets" {
}



#------------------------------------INTERNET GATEWAY-------------------------------·#

variable "igw_name" {
    default = "team-4-cs-igw"
}

#-------------------------------------------EIP-----------------------------------------#

variable "eip_name" {

}

#------------------------------------NAT GATEWAY-------------------------------·#

variable "nat_name" {

}

#------------------------------------ROUTE TABLES------------------------------------#


variable "rt_cidr_block" {
    default = "0.0.0.0/0"
}

variable "rt_name" {

}



# variable "alb_security_groups" {
#   default = ["aws_security_group.${var.security_group_name}.id"]
# }

# variable "alb_subnets" {
#     #default = COUNT?
# }