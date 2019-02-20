provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-west-2"
}

resource "aws_instance" "ec2public" {
  ami           = "ami-032509850cf9ee54e"
  instance_type = "t2.micro"
  subnet_id     = "subnet-07c6811d5a119875c"
  key_name      = "Ec2KeyPair"
  associate_public_ip_address = "true"
  security_groups = ["sg-0df871cb89d78602d"]
  tags = {
    type = "Jenkins"
    Name = "Jenkins"
  }
}

#resource "aws_instance" "ec2private" {
#  ami           = "ami-032509850cf9ee54e"
#  instance_type = "t2.micro"
#  subnet_id     = "subnet-01383d6fcf8472c81"
#  key_name      = "Ec2KeyPair"
#  associate_public_ip_address = "false"
#  security_groups = ["sg-059a0455a434a0929"]
#  tags = {
#    type = "Frontend"
#    Name = "Frontend"
#    }
#  iam_instance_profile = "EC2ManageS3"
#}

resource "aws_launch_configuration" "frontendconfig" {
  name          = "frontendconfig"
  image_id      = "ami-0dc2d01a049d42d6d"
  instance_type = "t2.micro"
  key_name = "Ec2KeyPair"
  security_groups = ["sg-059a0455a434a0929"]
  iam_instance_profile = "EC2ManageS3"
}

resource "aws_autoscaling_group" "myautoscaling" {
  name = "myautoscaling"
  launch_configuration = "${aws_launch_configuration.frontendconfig.name}"
  vpc_zone_identifier=["subnet-01383d6fcf8472c81"]
  min_size = 1
  max_size = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  tag {
  key = "Name"
  value = "ec2 instance"
  propagate_at_launch = true
  }
}

resource "aws_iam_instance_profile" "EC2ManageS3" {
  name = "EC2ManageS3"
  role = "ManageS3"
}

resource "aws_s3_bucket" "s3test" {
  bucket = "gammas3statichtml"
}
