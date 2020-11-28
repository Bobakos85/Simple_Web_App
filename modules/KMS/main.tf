resource "aws_kms_key" "rds_kms_key" {
  description         = "CMK Key used to encrypt and decrypt RDS data"
  policy              = data.aws_iam_policy_document.rds_access.json
  enable_key_rotation = "true"
}

resource "aws_kms_alias" "rds_kms_key_alias" {
  name          = "alias/${var.application_name}/cmk/rds"
  target_key_id = aws_kms_key.rds_kms_key.key_id
}