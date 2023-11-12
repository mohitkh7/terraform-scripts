variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
  description = "access key for AWS auth"
  type        = string
}

variable "AWS_SECRET_KEY" {
  description = "secret key for AWS auth"
  type        = string
}

variable "PROJECT" {
  description = "Name of the project"
  type        = string
  default     = "my-project"
}