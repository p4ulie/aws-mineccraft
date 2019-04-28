# https://github.com/terraform-providers/terraform-provider-aws

variable "ssh_public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/aws-minecraft.pub
DESCRIPTION

  default = "~/.ssh/aws-minecraft.pub"
}

variable "ssh_key_name" {
  description = "Desired name of AWS key pair"
  default     = "aws-minecraft"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-1"
}

variable "aws_instance_type" {
  description = "AWS instance type."
  default     = "t2.micro"
}
