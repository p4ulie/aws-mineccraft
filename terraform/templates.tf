data "template_file" "instance_provisioning" {
  template = "${file("templates/instance_provisioning.tpl")}"

  vars = {
    MINECRAFT_USER            = "${var.minecraft_user}"
    MINECRAFT_GROUP           = "${var.minecraft_group}"
    MINECRAFT_DIRECTORY       = "${var.minecraft_directory}"
    MINECRAFT_DOWNLOAD_URL    = "${var.minecraft_download_url}"
    MINECRAFT_SERVER_FILENAME = "${var.minecraft_server_filename}"
  }
}

data "template_file" "instance_configuration" {
  template = "${file("templates/instance_configuration.tpl")}"

  vars = {
    MINECRAFT_USER           = "${var.minecraft_user}"
    MINECRAFT_GROUP          = "${var.minecraft_group}"
    MINECRAFT_DIRECTORY      = "${var.minecraft_directory}"
    MINECRAFT_S3_BUCKET_NAME = "${var.s3_bucket_name}"
  }
}

data "template_file" "minecraft_systemd_service" {
  template = "${file("templates/minecraft_systemd_service.tpl")}"

  vars = {
    MINECRAFT_USER      = "${var.minecraft_user}"
    MINECRAFT_GROUP     = "${var.minecraft_group}"
    MINECRAFT_DIRECTORY = "${var.minecraft_directory}"
    MINECRAFT_JOPTS     = "${var.minecraft_java_opts}"
  }
}

data "template_file" "backup_to_s3" {
  template = "${file("templates/backup_to_s3.sh.tpl")}"

  vars = {
    MINECRAFT_USER           = "${var.minecraft_user}"
    MINECRAFT_GROUP          = "${var.minecraft_group}"
    MINECRAFT_DIRECTORY      = "${var.minecraft_directory}"
    MINECRAFT_S3_BUCKET_NAME = "${var.s3_bucket_name}"
  }
}

data "template_file" "restore_from_s3" {
  template = "${file("templates/restore_from_s3.sh.tpl")}"

  vars = {
    MINECRAFT_USER           = "${var.minecraft_user}"
    MINECRAFT_GROUP          = "${var.minecraft_group}"
    MINECRAFT_DIRECTORY      = "${var.minecraft_directory}"
    MINECRAFT_S3_BUCKET_NAME = "${var.s3_bucket_name}"
  }
}
