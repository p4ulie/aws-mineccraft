# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "~/.aws/credentials"
  profile = "aws-minecraft"
}
