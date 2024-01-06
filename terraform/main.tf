resource "aws_instance" "minecraft_server" {
  instance_type = "${var.aws_instance_type}"

  # ami           = "${var.ami_default}"
  ami = "${var.ami_custom == "" ? var.ami_default : var.ami_custom}"

  key_name = "${aws_key_pair.minecraft_ssh_key.key_name}"

  iam_instance_profile = "minecraft_server_instance_profile"

  # Our Security group to allow network access to specified ports (SSH, ...)
  vpc_security_group_ids = ["${aws_security_group.minecraft_server.id}"]
  subnet_id              = "${aws_subnet.minecraft_server.id}"

  tags   = var.aws_tags

  connection {
    user = "ec2-user"
    private_key = tls_private_key.minecraft_ssh_key.private_key_openssh
    host = self.public_ip
  }

  # Copies generated SystemD service file
  provisioner "file" {
    content     = "${data.template_file.minecraft_systemd_service.rendered}"
    destination = "/home/ec2-user/minecraft.service"
  }

  # Copies backup script
  provisioner "file" {
    content     = "${data.template_file.backup_to_s3.rendered}"
    destination = "/home/ec2-user/backup_to_s3.sh"
  }

  # Copies restore script
  provisioner "file" {
    content     = "${data.template_file.restore_from_s3.rendered}"
    destination = "/home/ec2-user/restore_from_s3.sh"
  }

#  provisioner "remote-exec" {
#    inline = [
#      "groupadd ${var.minecraft_group}",
#      "useradd --create-home --gid ${var.minecraft_group} ${var.minecraft_user}",
#      "mkdir -p ${var.minecraft_directory}",
#      "mkdir -p ${var.minecraft_directory}/data",
#      "mkdir -p ${var.minecraft_directory}/bin",
#      "chown -R ${minecraft_user}:${minecraft_group} ${minecraft_directory}",
#      "sudo mv /home/ec2-user/minecraft.service /etc/systemd/system/minecraft.service",
#      "sudo chown root:root /etc/systemd/system/minecraft.service",
#      "sudo systemctl daemon-reload",
#      "sudo mv /home/ec2-user/backup_to_s3.sh ${var.minecraft_directory}/bin/backup_to_s3.sh",
#      "sudo chown ${var.minecraft_user}:${var.minecraft_group} /etc/systemd/system/minecraft.service",
#      "sudo mv /home/ec2-user/restore_from_s3.sh ${var.minecraft_directory}/bin/restore_from_s3.sh",
#      "sudo chown ${var.minecraft_user}:${var.minecraft_group} /etc/systemd/system/minecraft.service",
#      "echo 'eula=true' > ${var.minecraft_directory}/data/eula.txt",
#      "chown ${var.minecraft_user}:${var.minecraft_group} ${var.minecraft_directory}/data/eula.txt",
#    ]
#  }

  # generated script for provision the instance
  # user_data = "${base64encode(data.template_file.instance_provisioning.rendered)}"
  user_data = "${var.ami_custom == "" ? base64encode(data.template_file.instance_provisioning.rendered) : base64encode(data.template_file.instance_configuration.rendered)}"
}

resource "aws_eip" "minecraft_server" {
  domain   = "vpc"
}

resource "aws_eip_association" "minecraft_server" {
  instance_id   = aws_instance.minecraft_server.id
  allocation_id = aws_eip.minecraft_server.id
}

resource "aws_route53_record" "minecraft_server" {
  zone_id = "${aws_route53_zone.minecraft_server.zone_id}"
  name    = "server"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.minecraft_server.public_ip}"]
}
