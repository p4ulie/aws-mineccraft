resource "aws_s3_bucket" "minecraft_server" {
  bucket = "${var.s3_bucket_name}"

  tags = var.aws_tags

  # transition {
  #   days          = 30
  #   storage_class = "STANDARD_IA" # or "ONEZONE_IA"
  # }

  # transition {
  #   days          = 60
  #   storage_class = "GLACIER"
  # }

  # expiration {
  #   days = 90
  # }
}

resource "aws_s3_bucket_acl" "minecraft_server" {
  bucket = aws_s3_bucket.minecraft_server.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "minecraft_server" {
  bucket = aws_s3_bucket.minecraft_server.id
  versioning_configuration {
    status = "Disabled"
  }
}
