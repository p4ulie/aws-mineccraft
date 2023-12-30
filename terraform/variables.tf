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
  default     = "t2.medium"
}

variable "aws_instance_name" {
  description = "AWS instance name."
  default     = "Minecraft server"
}

variable "ami_default" {
  description = "Default base AMI"
  default     = "ami-02da8ff11275b7907"
}

variable "ami_custom" {
  description = "Customized AMI"
  default     = ""
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket to store Minecraft server world backups"
  default     = "s3-minecraft-p4ulie-net-world-backup"
}

variable "aws_tags" {
  type        = map(string)
  description = "Tags to add to all resources."
  default = {
    "project" = "aws-minecraft"
  }
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
  default     = "-Xms3000M -Xmx3000M"
}

variable "minecraft_download_url" {
  description = "URL for downloading Minecraft server (1.20.4)"
  default     = "https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar"
}

variable "minecraft_server_filename" {
  description = "Local filename for downloaded Minecraft server"
  default     = "minecraft_server.jar"
}
