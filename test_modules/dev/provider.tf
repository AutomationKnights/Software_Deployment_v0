terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
  
  backend "s3" {
    bucket         = "terraform-backendv01"
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "tfstate" # Used for state locking
    encrypt        = true
  }
}
