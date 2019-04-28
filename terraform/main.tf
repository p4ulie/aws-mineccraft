# https://github.com/terraform-providers/terraform-provider-aws

resource "aws_instance" "minecraft-server" {
  connection {
    user = "ec2-user"
  }

  instance_type = "${var.aws_instance_type}"

  # Lookup the correct AMI based on the region we specified
  # ami = "${lookup(var.aws_amis, var.aws_region)}"
  ami = "${data.aws_ami.amazon_linux_2.id}"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

  # Our Security group to allow network access to specified ports (SSH, ...)
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  subnet_id = "${aws_subnet.default.id}"

  tags {
    Name = "${var.aws_instance_name}"
  }

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo yum -y install tmux mc",
    ]
  }
}
