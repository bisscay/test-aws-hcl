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

variable "my_ip" {
  description = "(Required) Your IP address used for SSH access."
  type        = string
}

variable "existing_key_name" {
  description = "(Required) The name of an existing key pair."
  type        = string
}
