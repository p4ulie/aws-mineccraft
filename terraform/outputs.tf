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
