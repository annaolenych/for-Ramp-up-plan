provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-central-1"
}



terraform {
  backend "s3" {
    bucket = "bucket-studing"
    key = "tfstate"
    region     = "eu-central-1"
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}