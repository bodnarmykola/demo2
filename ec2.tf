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
}

resource "aws_s3_bucket" "s3test" {
  bucket = "gammas3statichtml"
}
