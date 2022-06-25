packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2" #"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# locals {
#   timestamp = regex_replace(timestamp(), "[- TZ:]", "")
# }

source "amazon-ebs" "centos" {
  ami_name      = "centos-packer"
  instance_type = "t2.micro"
  force_deregister = true
  force_delete_snapshot = true
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "CentOS-7*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      architecture = "x86_64"
    }
    most_recent = true
    owners      = ["679593333241"]
  }
  ssh_username = "centos"
}

build {
  name    = "centos-packer"
  sources = [
    "source.amazon-ebs.centos"
  ]
  provisioner "shell" {
    script = "/workspace/init.sh"
    execute_command = "echo 'packer' | sudo -S bash -c '{{ .Vars }} {{ .Path }}'"
}
}