resource "aws_s3_bucket" "minecraft_server" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name = "minecraft_p4ulie_net_backup"
  }

  versioning {
    enabled = true
  }

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
