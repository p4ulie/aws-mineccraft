terraform {
  backend "s3" {
    bucket         = "p4ulie-tfstates-development"
    key            = "aws-minecraft-terraform.state"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }
}
