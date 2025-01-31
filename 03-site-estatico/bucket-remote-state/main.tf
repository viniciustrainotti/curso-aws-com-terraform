terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "tf014"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote-state" {
  bucket        = "tfstate-${data.aws_caller_identity.current.account_id}"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    Description = "Stores terraform remote state files"
    ManagedBy   = "Terraform"
    Owner       = "Vinícius Trainotti"
    CreatedAt   = "2021-11-10"
  }
}

resource "aws_dynamodb_table" "lock-table" {
  name           = "tflock-${aws_s3_bucket.remote-state.bucket}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote-state.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote-state.arn
}

output "remote_state_dynamodb" {
  value = aws_dynamodb_table.lock-table.name
}