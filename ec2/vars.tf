variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  type    = string
  default = "ap-south-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-south-1 = "ami-03b8a287edc0c1253"
  }
}
