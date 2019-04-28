data "aws_region" "current" {
}

output "region" {
  value = "${data.aws_region.current.name}"
}

output "minecraft-server-id" {
  value = "${aws_instance.minecraft-server.id}"
}