data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "ot-cloud-kit-bucket"
    key    = "ot/module/networkskeleton/terraform.tfstate"
    region = "us-east-1"
  }
}
