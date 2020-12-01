terraform {
  backend "s3" {
    bucket = "tf-state-thomas"
    key    = "terraform/simplewebapp"
    region = "eu-west-2"
  }
}