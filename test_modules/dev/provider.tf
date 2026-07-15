terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"

  # Local backend for development. For production, use S3 with DynamoDB locking:
  #
  # backend "s3" {
  #   bucket         = "<your-state-bucket>"
  #   key            = "dev/terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "<your-lock-table>"
  #   encrypt        = true
  # }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}