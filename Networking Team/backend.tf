terraform {
  backend "s3" {
    bucket = "for-projects-tf"
    key    = "eip.tfstate"
    region = "ap-south-1"
  }
}