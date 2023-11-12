variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "PROJECT" {
  description = "Name of the project"
  type        = string
}

variable "AWS_ACCESS_KEY" {
  description = "access key for AWS auth"
  type        = string
}

variable "AWS_SECRET_KEY" {
  description = "secret key for AWS auth"
  type        = string
}