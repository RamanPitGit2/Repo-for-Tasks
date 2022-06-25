data "aws_ami" "ubuntu_ami" {
  most_recent = true
  name_regex  = var.images["Ubuntu"][var.ubuntu_os_version].name_regex
  owners      = [var.images["Ubuntu"][var.ubuntu_os_version].owner_id]

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

data "aws_subnet" "ubuntu_subnet" {
 filter {
    name   = "vpc-id"
    values = [aws_vpc.terra_vpc.id]
  }
   filter {
    name   = "tag:Name"
    values = [var.subnet_Ubuntu]
  }
  depends_on=[aws_subnet.public, aws_subnet.private]
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro"
  key_name= aws_key_pair.my.key_name
  count = 1
  vpc_security_group_ids = [aws_security_group.Security_Group_Public.id]
  
  user_data = "${file("userdata_ubuntu.sh")}"
  subnet_id = data.aws_subnet.ubuntu_subnet.id
  tags = {
    Name = "Ubuntu"
  }
}


