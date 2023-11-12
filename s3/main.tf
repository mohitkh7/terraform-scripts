provider "aws" {
  region     = "ap-south-1"
}

variable "keywords" {
  description = "project keywords"
  type        = string
  default     = "variable terraform"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "mohitkh7-terraform-learn-37dd64c529e9"

  tags = {
    Name     = "mohitkh7-terraform-learn"
    Project  = "terraform-learning"
    Keywords = var.keywords
  }
}

resource "aws_s3_bucket_versioning" "my_s3_bucket" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_arn" {
  description = "ARN of S3 bucket created"
  value       = aws_s3_bucket.my_s3_bucket.arn
}