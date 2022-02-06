#-------------------------------------VPC--------------------------------------------#
variable "vpc_tags_name" {
    default = "team-4-cs"
}

variable "cidr_block" {}

#------------------------------------SUBNETS-----------------------------------------#

variable "subnets" {
}

variable "pub_a_subnets_id" {

}

#------------------------------------INTERNET GATEWAY-------------------------------·#

variable "igw_name" {
    default = "team-4-cs-igw"
}

#------------------------------------ROUTE TABLES------------------------------------#

variable "rt_name" {
  
}

variable "rt_cidr_block" {
    default = "0.0.0.0/0"
}

#------------------------------------NAT GATEWAY-------------------------------·#



# variable "alb_security_groups" {
#   default = ["aws_security_group.${var.security_group_name}.id"]
# }

# variable "alb_subnets" {
#     #default = COUNT?
# }