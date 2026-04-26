output "app_server_ip" {
  value = aws_instance.app.public_ip
}