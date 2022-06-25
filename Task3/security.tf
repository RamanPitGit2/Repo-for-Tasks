locals {
  subnet_list = [var.subnet_Ubuntu, var.subnet_CentOS]
  subnet_cidrs = [for subnet in flatten([aws_subnet.public,aws_subnet.private]) : subnet.cidr_block if contains(local.subnet_list, lookup(subnet.tags,"Name","Not Found")) ] 
}

# data "aws_subnets" "selected" {
#  filter {
#     name   = "tag:Name"
#     values = local.subnet_list
#   }
#   depends_on=[aws_subnet.public,aws_subnet.private]
# }

# data "aws_subnet" "subnet" {
#   for_each = toset(data.aws_subnets.selected.ids)
#   id = each.value
#   depends_on=[data.aws_subnets.selected]
# }

# locals {
#   subnet_cidrs = [for s in data.aws_subnet.subnet : s.cidr_block]
# }

# Create the Public Security Group
resource "aws_security_group" "Security_Group_Public" {
  vpc_id       = aws_vpc.terra_vpc.id
  name         = "public"
  description  = "Security Group Public"
  
  # allow ingress of port 22 for tcp
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  # allow ingress of port 80 for http
  ingress { 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

 # allow ingress of port 433 for https
  ingress { 
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  # allow ingress of icmp 
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #tcp
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "Security Group Public"
   Description = "Security Group Public"
}
}




# Create the Private Security Group
resource "aws_security_group" "Security_Group_Private" {
  vpc_id       = aws_vpc.terra_vpc.id
  name         = "private"
  description  = "Security Group Private"
  

 # allow ingress of port 22 for tcp
  ingress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self = true
  } 

  # allow ingress of port 80 for http
  ingress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self = true
  } 

 # allow ingress of port 433 for https
  ingress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    self = true
  } 

  # allow ingress of icmp 
  ingress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port = -1
    to_port = -1
    protocol = "icmp"
    self = true
  } 
  


  # allow egress of port 22 for tcp
  egress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self = true
  } 

  # allow egress of port 80 for http
  egress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self = true
  } 

 # allow egress of port 433 for https
  egress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    self = true
  } 

  # allow egress of icmp 
  egress {
    security_groups = [aws_security_group.Security_Group_Public.id]
    from_port = -1
    to_port = -1
    protocol = "icmp"
    self = true
  } 

tags = {
   Name = "Security Group Private"
   Description = "Security Group Private"
}
}