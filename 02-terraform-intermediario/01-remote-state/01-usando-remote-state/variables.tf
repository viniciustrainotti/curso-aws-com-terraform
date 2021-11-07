variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "tf014"
}

variable "ami" {
  type        = string
  description = ""
  default     = "ami-01cc34ab2709337aa"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"
}
