data "aws_subnet" "centos_subnet" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.terra_vpc.id]
  }
   filter {
    name   = "tag:Name"
    values = [var.subnet_CentOS]
  }
  depends_on=[aws_subnet.public,aws_subnet.private]
}

resource "aws_instance" "centos" {
  ami           = "ami-00e87074e52e6c9f9"
  instance_type = "t2.micro"
  key_name= aws_key_pair.my.key_name
  count = 1
  vpc_security_group_ids = [aws_security_group.Security_Group_Private.id]
  
  user_data = "${file("userdata_centos.sh")}"
  subnet_id = data.aws_subnet.centos_subnet.id
  tags = {
    Name = "CentOS"
  }
}