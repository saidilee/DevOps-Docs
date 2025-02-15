resource "aws_launch_template" "web_template" {
  name = "web_launch_template"
  image_id = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name = "Ashok"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      name = "Web-server"
    }
  }

}
