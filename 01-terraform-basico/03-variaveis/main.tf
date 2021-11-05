terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# terraform init
# terraform plan ~ja pega as variaveis de dev 
# terraform apply -auto-approve
# terraform plan -var-file="prod.tfvars"
# terraform destroy -var-file="prod.tfvars" 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = var.instance_tags
}
