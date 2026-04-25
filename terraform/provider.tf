terraform {
  required_version = "<= 1.7.5" # Forcing which version tf should use
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 5.53.0" # Forcing which version plugin should use
    }
  }
}

# Configure the AWS Provider

provider "aws" {
  region = "us-east-1"
}





