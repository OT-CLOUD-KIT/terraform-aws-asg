terraform {
  backend "s3" {
    bucket = "ot-cloud-kit-bucket"
    key    = "ot/module/ASG/terraform.tfstate"
    region = "us-east-1"

  }
}