# define role for EC2 instances, allow assuming roles
resource "aws_iam_role" "minecraft_server_instance_role" {
  name               = "minecraft_server_instance_role"
  assume_role_policy = file("iam/assume_role_policy.json")
}

# attach policy to allow SSM
data "aws_iam_policy" "AmazonEC2RoleforSSM" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "attach-SSM" {
  role       = aws_iam_role.minecraft_server_instance_role.name
  policy_arn = data.aws_iam_policy.AmazonEC2RoleforSSM.arn
}

# attach policy to allow access to S3 bucket
data "template_file" "minecraft_allow_bucket_access_template" {
  template = file("iam/allow_bucket_access_policy.json.tpl")

  vars = {
    S3_BUCKET_NAME = "${var.s3_bucket_name}"
  }
}

resource "aws_iam_policy" "minecraft_allow_s3_bucket_access_policy" {
  name        = "minecraft_allow_s3_bucket_access_policy"
  description = "Policy for allowing access to S3 bucket from EC2 instance"
  policy      = data.template_file.minecraft_allow_bucket_access_template.rendered
}

resource "aws_iam_role_policy_attachment" "minecraft_attach_s3_bucket_policy" {
  role       = aws_iam_role.minecraft_server_instance_role.name
  policy_arn = aws_iam_policy.minecraft_allow_s3_bucket_access_policy.arn
}

# define instance profile
resource "aws_iam_instance_profile" "minecraft_server_instance_profile" {
  name = "minecraft_server_instance_profile"
  role = aws_iam_role.minecraft_server_instance_role.name
}
