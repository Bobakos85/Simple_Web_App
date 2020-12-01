output "rds_kms_key_arn" {
  value = aws_kms_key.rds_kms_key.arn
}

output "rds_kms_key_id" {
  value = aws_kms_key.rds_kms_key.key_id
}