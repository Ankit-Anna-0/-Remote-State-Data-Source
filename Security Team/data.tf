data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "for-projects-tf"
    key    = "eip.tfstate"
    region = "ap-south-1"
    }
  }