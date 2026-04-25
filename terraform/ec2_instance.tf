resource "aws_instance" "app_server" {
  ami                         = "ami-098e39bafa7e7303d"
  instance_type               = "t2.micro"
  key_name                    = "laptopkey"
  subnet_id                   = aws_subnet.secure_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all_access.id}"]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  tags = {
    Name = "app-server"
  }
}


