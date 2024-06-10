output "vpc_id" {
  value = aws_vpc.vpc-sandesh.id
}
output "rds_endpoint" {
  value = aws_db_instance.DB-Terraform-Sandesh.endpoint
}
