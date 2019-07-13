terraform {
  backend "s3" {
    region = "ap-southeast-1"
    bucket = "idn13072019-tf-state"
    key    = "tf-state/"

  }
}

provider "aws" {
  region = "ap-southeast-1"
}

