terraform {
  required_version = "<= 1.7.5" # Forcing which version tf should use
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 5.53.0" # Forcing which version plugin should use
    }
  }
  backend "s3" {
    bucket         = "dev-data-324793865868-us-east-1-an" # Name of the S3 bucket where the state will be stored.
    key            = "secure.tfstate"                     # Path within the bucket where the state will be read/written.
    region         = "us-east-1"                          # AWS region of the S3 bucket.
    dynamodb_table = "test1_terraform-locks"              # DynamoDB table used for state locking.
    encrypt        = true                                 # Ensures the state is encrypted at rest in S3.
  }
}

# Configure the AWS Provider

provider "aws" {
  region = "us-east-1"
}





