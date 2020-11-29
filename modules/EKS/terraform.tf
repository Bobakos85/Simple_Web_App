terraform {
  backend "s3" {
    bucket = "tf-state-thomas"
    key    = "terraform/eks"
    region = "eu-west-2"
  }
}