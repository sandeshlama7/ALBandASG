resource "aws_launch_template" "ec2_template" {
  name_prefix            = "LT-EC2-"
  image_id               = local.ami
  # key_name               = "Key.Sandesh.pem"
  instance_type          = local.instance_type
  # vpc_security_group_ids = [aws_security_group.sg-vpc.id]

  iam_instance_profile {
    name = data.aws_iam_instance_profile.IAM-Role.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_sg.id]
  }

  user_data = base64encode(templatefile("userdata.sh", {

  }))
}
