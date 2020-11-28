terraform {
  backend "s3" {
    bucket = "tf-state-thomas"
    key    = "terraform/vpc"
    region = "eu-west-2"
  }
}