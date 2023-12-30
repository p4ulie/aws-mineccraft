resource "aws_route53_zone" "minecraft_server" {
  name = "minecraft.p4ulie.net"

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = {
    Name = "Minecraft"
  }
}
