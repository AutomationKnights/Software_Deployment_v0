terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
  
  backend "s3" {
    bucket         = "terraform-backend-638111422513-ap-south-1-an"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tfstate" # Used for state locking
    encrypt        = true
  }
}
