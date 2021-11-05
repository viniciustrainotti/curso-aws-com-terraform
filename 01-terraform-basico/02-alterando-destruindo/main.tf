terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
provider "aws" {
  region  = "us-east-1" # Recomendo a região us-east-1 se você estiver no Brasil
  profile = "tf014"     # Usar este atributo somente se não for o profile "default" no arquivo ~/.aws/credentials
}

# terraform validate
# terraform fmt
# terraform plan -out="tfplan.out"
# terraform destroy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "viniciustrainotti804e8c700f405ef9951baa6619f33f9b0d9dccde12"
  acl    = "private"

  tags = {
    Name        = "My first Terraform bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Vinícius Trainotti"
    Created     = "2021/11/04"
  }
}
