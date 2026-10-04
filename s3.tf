terraform {
  backend "s3" {
    bucket = "terraform-state-file.07"
    key    = "assignment-1/terraform.tfstate"
    region = "us-east-1"
  }
}