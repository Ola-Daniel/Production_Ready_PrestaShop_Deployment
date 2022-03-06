# config.tf
provider "aws" {
  region  = "eu-west-2"
  profile = "tfuser"
}

terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket  = "olugbotemiterraformbucket"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    profile = "tfuser"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69.0"
    }
  }
}
