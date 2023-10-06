packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_aws_account_id" {
  type    = string
  default = ""
}

variable "applicaiton_name" {
  type    = string
  default = "cloudbinary"
}

variable "application_version" {
  type    = string
  default = "1.0.0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "packer_profile" {
  type    = string
  default = "packer-ec2-s3"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami" {
  type    = string
  default = "ami-053b0d53c279acc90"
}

# could not parse template for following block: "template: hcl2_upgrade:2: bad character U+0060 '`'"

source "amazon-ebs" "ubuntu" {
  ami_name                    = "tomcloudbinary"
  associate_public_ip_address = "true"
  force_delete_snapshot       = "true"
  force_deregister            = "true"

  instance_type = "t2.micro"
  profile       = "default"
  region        = "us-east-1"
  source_ami    = "ami-053b0d53c279acc90"
  ssh_username  = "ubuntu"
  tags = {
    CreatedBy = "Packer"
    Name      = "tom"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = ["sudo apt-get update",
      "sudo apt-get install software-properties-common -y"
    ]
  }

  provisioner "shell" {
    inline = ["sudo add-apt-repository --yes --update ppa:ansible/ansible", "sudo apt-get install ansible -y"]
  }

  provisioner "shell" {
    inline = ["sudo apt-get install git -y"]
  }

  provisioner "shell" {
    inline = ["sudo apt-get install curl -y"]
  }

  provisioner "shell" {
    inline = ["sudo apt-get install wget -y"]
  }

  provisioner "shell" {
    inline = ["sudo apt-get update", "sudo apt-get install zip -y"]
  }
}
