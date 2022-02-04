#-------------------------------------VPC--------------------------------------------#
vpc_tags_name = "team-4-cs"

cidr_block = "10.0.0.0/16"

#------------------------------------SUBNETS-----------------------------------------#

subnets = [ 
    
        {
            tag = "team4-subnet-pub-a"
            cidr_block = "10.0.1.0/25"
            availability_zone = "us-east-2a"
        },
        {
            tag = "team4-subnet-pri-a"
            cidr_block = "10.0.1.128/25"
            availability_zone = "us-east-2a"
        },
        {
            tag = "team4-subnet-pub-b"
            cidr_block = "10.0.3.0/25"
            availability_zone = "us-east-2b"
        },
        {
            tag = "team4-subnet-pri-b"
            cidr_block = "10.0.3.128/25"
            availability_zone = "us-east-2b"
        }
    ]


#  "vpc_id" {
#     default = "aws_vpc.${var.vpc_name}.id"
# }

# subnet_cidr_block = { for x in ["10.0.1.0/25", "10.0.1.128/25", "10.1.0.0/25", "10.1.0.128/25"] : "cidr_block" => x }

# subnet_availability_zone = ["us-east-1a", "us-east-1b"]

# #----------------------------------ALB---------------------------------------------#

#  "alb_name" {}

#  "internal" {
#     default = "false"
# }

#  "load_balancer_type" {
#     default = "application"
# }

# variable "alb_security_groups" {
#   default = ["aws_security_group.${var.security_group_name}.id"]
# }

# variable "alb_subnets" {
#     #default = COUNT?
# }