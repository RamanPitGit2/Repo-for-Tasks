variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
    description = " all subnets"
    default = "10.20.0.0/16"
}

variable "subnets_cidr" {
	type = list
	default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "subnets_private_cidr" {
	type = list
	default = ["10.20.0.0/24"]
}

variable "azs" {
	type = list
	default = ["us-east-1a", "us-east-1b"]
}

variable "azs_private" {
	type = list
	default = ["us-east-1a"]
}

variable "subnet_Ubuntu" {
	default = "Subnet-public-1"
}

variable "subnet_CentOS" {
	default = "Subnet-private-1"
}   

variable "images"{
  default ={"Ubuntu"={"20.04"={"name_regex"="^ubuntu/images/hvm-ssd/ubuntu-.*-20[.]04-amd64-server-","owner_id"="099720109477"}},
            "CentOS"={"7.9"={"name_regex"="centos-packer","owner_id"="682893647259"}}
  }
}

variable "ubuntu_os_version"{
  default ="20.04"
}

variable "centos_os_version"{
  default ="7.9"
}

