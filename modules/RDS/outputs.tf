output "db_instance_backend_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

output "db_instance_backend_name" {
  value = aws_db_instance.db_instance.name
}

output "db_instance_backend_port" {
  value = aws_db_instance.db_instance.port
}

output "db_instance_backend_resource_id" {
  value = aws_db_instance.db_instance.resource_id
}

output "db_instance_backend_sg_id" {
  value = aws_security_group.db_sg.id
}

output "db_instance_backend_username" {
  value = aws_db_instance.db_instance.username
}

output "db_instance_id" {
  value = aws_db_instance.db_instance.id
}