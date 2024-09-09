terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "terraformstate-riya-ap-south-1"
    key     = "terraform-account-a-state.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
