resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }
}