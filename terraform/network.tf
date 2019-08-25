# Create a VPC to launch our instances into
resource "aws_vpc" "minecraft_server" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Minecraft"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "minecraft_server" {
  vpc_id = "${aws_vpc.minecraft_server.id}"

  tags = {
    Name = "Minecraft"
  }
}

# Grant the internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.minecraft_server.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.minecraft_server.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "minecraft_server" {
  vpc_id                  = "${aws_vpc.minecraft_server.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Minecraft"
  }
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "minecraft_server" {
  name        = "minecraft-network-ports"
  description = "Used for the Minecraft server"
  vpc_id      = "${aws_vpc.minecraft_server.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Minecraft access from anywhere
  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Pocketmine access from anywhere
  ingress {
    from_port   = 19132
    to_port     = 19132
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Minecraft"
  }
}
