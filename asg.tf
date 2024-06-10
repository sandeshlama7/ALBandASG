resource "aws_security_group" "asg_sg" {
  name        = "SG-ASG"
  description = "SG for the Public Instance"
  vpc_id      = aws_vpc.vpc-sandesh.id
  tags = {
    Name = "SG-ASG"
  }
  ingress {
    description = "Allow HTTP"
    cidr_blocks = [local.cidr_all]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    description = "Allow HTTPS"
    cidr_blocks = [local.cidr_all]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    description = "Outbound Rules to Allow All Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.cidr_all]
  }
}

data "aws_iam_instance_profile" "IAM-Role" {
  name = "ec2-SSM-Sandesh"
}

resource "aws_autoscaling_attachment" "ASG-Sandesh-Attachment" {
  autoscaling_group_name = aws_autoscaling_group.ASG-Sandesh.name
  lb_target_group_arn    = aws_lb_target_group.TG-tf.arn
}

resource "aws_autoscaling_group" "ASG-Sandesh" {
  name                = "ASG-Sandesh"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  force_delete        = true
  target_group_arns   = [aws_lb_target_group.TG-tf.arn]
  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.subnets["public-subnet-1a"].id, aws_subnet.subnets["public-subnet-1b"].id]

  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG-Sandesh"
    propagate_at_launch = true
  }
}

# Target Group
resource "aws_lb_target_group" "TG-tf" {
  name     = "TG-ALB-Sandesh"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-sandesh.id

  health_check {
    enabled             = true
    path                = "/"
    interval            = 60
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 50
    protocol            = "HTTP"
    matcher             = "200-299"
  }
}
