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
  region  = "us-east-1"
  profile = "tf014"
}

data "aws_caller_identity" "current" {}

# https://technology.doximity.com/articles/terraform-s3-backend-best-practices
resource "aws_s3_bucket" "remote-state" {
    bucket = "tfstate-${data.aws_caller_identity.current.account_id}"
    acl = "private"
    
    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = aws_kms_key.terraform-bucket-key.arn
                sse_algorithm     = "aws:kms"
            }
        }
    }

    tags = {
        Description = "Stores terraform remote state files"
        ManagedBy   = "Terraform"
        Owner       = "Vinícius Trainotti"
        CreatedAt   = "2021-11-26"
    }
}

resource "aws_s3_bucket_public_access_block" "block" {
    bucket = aws_s3_bucket.remote-state.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_kms_key" "terraform-bucket-key" {
    description             = "This key is used to encrypt bucket objects"
    deletion_window_in_days = 10
    enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
    name          = "alias/terraform-bucket-key"
    target_key_id = aws_kms_key.terraform-bucket-key.key_id
}

resource "aws_dynamodb_table" "terraform-state" {
    name           = "tflock-${aws_s3_bucket.remote-state.bucket}"
    read_capacity  = 20
    write_capacity = 20
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