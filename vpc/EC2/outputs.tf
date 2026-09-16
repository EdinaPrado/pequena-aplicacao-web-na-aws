output "instance_ids" {
  value = aws_instance.web_server[*].id
}

output "public_ips" {
  value = aws_instance.web_server[*].public_ip
}

output "private_ips" {
  value = aws_instance.web_server[*].private_ip
}

output "security_group_id" {
  value = aws_security_group.instance.id
}