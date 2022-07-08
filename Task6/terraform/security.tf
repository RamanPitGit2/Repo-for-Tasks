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
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  # allow jnlp agent
   ingress { 
    from_port   = 50000
    to_port     = 50000
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