# # Amazon Linux 2 AMI - ami-0bbc25e23a7640b9b
# data "aws_ami" "amazon_linux_2" {
#   # Amazon organization id is 137112412989
#   owners = [
#     "amazon",
#   ]
#   most_recent = true
#   filter {
#     name = "architecture"
#     values = [
#       "x86_64",
#     ]
#   }
#   filter {
#     name = "root-device-type"
#     values = [
#       "ebs",
#     ]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter {
#     name   = "state"
#     values = ["available"]
#   }
#   filter {
#     name = "name"
#     values = [
#       "amzn2-ami-hvm-*-gp2",
#     ]
#   }
# }

