packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

# ---------------- VARIABLES ----------------
variable "region" {
  type = string
}

variable "source_ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

# ---------------- SOURCE ----------------
source "amazon-ebs" "ubuntu" {
  region        = var.region
  source_ami    = var.source_ami
  instance_type = var.instance_type
  ssh_username  = "ubuntu"

  associate_public_ip_address = true

  ami_name = "chandu-devops-team-${formatdate("YYYYMMDD-hhmmss", timestamp())}"

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  tags = {
    Name = "chandu-devops-team"
  }
}

# ---------------- BUILD ----------------
build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt update -y",
      "sudo apt install -y nginx git curl",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "curl -fsSL https://get.docker.com | sudo bash",
      "sudo usermod -aG docker ubuntu"
    ]
  }
}
