data "aws_ami" "amazon_linux_2" {
  # CentOS organization id is 679593333241
  owners = [
    "679593333241",
  ]

  most_recent = true

  filter {
    name = "name"

    values = [
      "Amazon Linux 2 *",
    ]
  }

  filter {
    name = "architecture"

    values = [
      "x86_64",
    ]
  }

  filter {
    name = "root-device-type"

    values = [
      "ebs",
    ]
  }
}