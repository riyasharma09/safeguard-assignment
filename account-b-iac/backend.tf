terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "terraformstate-riya2-ap-south-1"
    key     = "terraform-account-b-state.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
