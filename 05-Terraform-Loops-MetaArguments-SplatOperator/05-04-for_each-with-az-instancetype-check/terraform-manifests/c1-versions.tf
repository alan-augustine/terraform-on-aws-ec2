# Terraform Block
terraform {
  required_version = "~> 1.1" # which means any version equal & above 1.1 like 1.2, 1.3 etc and < 2.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = "us-east-1"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
