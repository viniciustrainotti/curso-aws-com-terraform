locals {
  ip_filepath = "ips.json"
  content_type = "application/json"

  common_tags = {
    Service     = "Curso Terraform"
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "Vinícius Trainotti"
  }
}
