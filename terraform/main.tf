resource "aws_instance" "minecraft_server" {
  instance_type = "${var.aws_instance_type}"
  ami           = "${var.ami_default}"
  key_name      = "${aws_key_pair.minecraft_ssh_key.id}"

  # Our Security group to allow network access to specified ports (SSH, ...)
  vpc_security_group_ids = ["${aws_security_group.minecraft_server.id}"]
  subnet_id              = "${aws_subnet.minecraft_server.id}"

  tags {
    Name = "${var.aws_instance_name}"
  }

  connection {
    user = "ec2-user"
  }

  # Copies generated SystemD service file
  provisioner "file" {
    content     = "${data.template_file.instance_provisioning.rendered}"
    destination = "/home/ec2-user/minecraft.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ec2-user/minecraft.service /etc/systemd/system/minecraft.service",
      "sudo daemon-reload",
    ]
  }

  # generated script for provision the instance
  user_data = "${base64encode(data.template_file.instance_provisioning.rendered)}"
}

resource "aws_route53_record" "minecraft_server" {
  zone_id = "${aws_route53_zone.minecraft_server.zone_id}"
  name    = "minecraft_server"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_instance.minecraft_server.public_dns}"]
}
