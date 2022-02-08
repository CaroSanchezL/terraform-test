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


#-------------------------------------------EIP-----------------------------------------#

eip_name = [ "eip_nat1", "eip_nat2" ]

#------------------------------------NAT GATEWAY-------------------------------·#

nat_name = [ "nat-gw1", "nat-gw2" ]

#------------------------------------ROUTE TABLES------------------------------------#

rt_name = [ "rt_pub1", "rt_pub2" ]