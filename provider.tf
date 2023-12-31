terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
  required_version = "~> 1.5.0"
}

provider "aws" {
  region = "eu-west-1"
}