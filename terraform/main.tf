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

  # connection {
  #   user = "ec2-user"
  #   private_key = ""
  # }


  # # Copies generated SystemD service file
  # provisioner "file" {
  #   content     = "${data.template_file.instance_provisioning.rendered}"
  #   destination = "/home/ec2-user/minecraft.service"
  # }


  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo mv /home/ec2-user/minecraft.service /etc/systemd/system/minecraft.service",
  #     "sudo daemon-reload",
  #   ]
  # }

  # generated script for provision the instance
  # user_data = "${base64encode(data.template_file.instance_provisioning.rendered)}"
  user_data = "${var.ami_custom == "" ? base64encode(data.template_file.instance_provisioning.rendered) : base64encode(data.template_file.instance_configuration.rendered)}"
}

resource "aws_route53_record" "minecraft_server" {
  zone_id = "${aws_route53_zone.minecraft_server.zone_id}"
  name    = "server"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.minecraft_server.public_ip}"]
}
