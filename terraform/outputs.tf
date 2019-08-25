data "aws_region" "current" {}

output "region" {
  value = "${data.aws_region.current.name}"
}

output "minecraft_server_id" {
  value = "${aws_instance.minecraft_server.id}"
}

output "minecraft_server_name" {
  value = "${var.aws_instance_name}"
}

output "public_ip" {
  value = "${aws_instance.minecraft_server.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.minecraft_server.public_dns}"
}

output "minecraft_ssh_key_private" {
  description = "SSH private key for Minecraft instances"
  value       = "${tls_private_key.minecraft_ssh_key.private_key_pem}"
  sensitive   = true
}

output "minecraft_ssh_key_public" {
  description = "SSH public key for Minecraft instances"
  value       = "${tls_private_key.minecraft_ssh_key.public_key_openssh}"
  sensitive   = true
}
