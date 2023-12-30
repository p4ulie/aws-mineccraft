resource "tls_private_key" "minecraft_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "minecraft_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.minecraft_ssh_key.public_key_openssh
}
