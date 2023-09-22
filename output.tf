output "public_address" {
  value       = aws_instance.nginx.public_ip
  description = "Public IP to Access Nginx"
}