data "aws_ami" "centos_ami" {
  most_recent = true
  name_regex  = var.images["CentOS"][var.centos_os_version].name_regex
  owners      = [var.images["CentOS"][var.centos_os_version].owner_id]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

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
  ami           = data.aws_ami.centos_ami.id
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