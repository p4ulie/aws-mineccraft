resource "aws_route53_zone" "minecraft_server" {
  name = var.minecraft_domain

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = {
    Name = "Minecraft"
  }
}
