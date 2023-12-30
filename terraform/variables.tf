# =============================================================================
#                                     AWS related variables
# =============================================================================

variable "ssh_key_name" {
  description = "Desired name of AWS key pair"
  default     = "minecraft-ssh"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-central-1"
}

variable "aws_instance_type" {
  description = "AWS instance type."
  default     = "t2.micro"
}

variable "aws_instance_name" {
  description = "AWS instance name."
  default     = "Minecraft server"
}

variable "ami_default" {
  description = "Default base AMI"
  default     = "ami-0bbc25e23a7640b9b"
}

variable "ami_custom" {
  description = "Customized AMI"
  default     = ""
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket to store Minecraft server world backups"
  default     = "s3-minecraft-p4ulie-net-backup"
}

# =============================================================================
#                                     Minecraft related variables
# =============================================================================

variable "minecraft_group" {
  description = "Default group for user running Minecraft server"
  default     = "minecraft"
}

variable "minecraft_user" {
  description = "Default user for running Minecraft server"
  default     = "minecraft"
}

variable "minecraft_directory" {
  description = "Default directory for installing Minecraft server"
  default     = "/opt/minecraft"
}

variable "minecraft_java_opts" {
  description = "Default java options for JVM running Minecraft server"
  default     = "-Xms1024M -Xmx1024M"
}

variable "minecraft_download_url" {
  description = "URL for downloading Minecraft server (1.14.4)"
  default     = "https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar"
}

variable "minecraft_server_filename" {
  description = "Local filename for downloaded Minecraft server"
  default     = "minecraft_server.jar"
}
