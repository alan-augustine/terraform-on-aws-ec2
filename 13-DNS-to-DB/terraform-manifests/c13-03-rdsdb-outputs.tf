# Ref: https://github.com/terraform-aws-modules/terraform-aws-rds/blob/v4.2.0/examples/complete-mysql/outputs.tf

output "rdsdb_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rdsdb.db_instance_address
}

output "rdsdb_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.rdsdb.db_instance_arn
}

output "rdsdb_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.rdsdb.db_instance_availability_zone
}

output "rdsdb_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.rdsdb.db_instance_endpoint
}

output "rdsdb_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = module.rdsdb.db_instance_hosted_zone_id
}

output "rdsdb_instance_id" {
  description = "The RDS instance ID"
  value       = module.rdsdb.db_instance_id
}

output "rdsdb_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.rdsdb.db_instance_resource_id
}

output "rdsdb_instance_status" {
  description = "The RDS instance status"
  value       = module.rdsdb.db_instance_status
}

output "rdsdb_instance_name" {
  description = "The database name"
  value       = module.rdsdb.db_instance_name
}

output "rdsdb_instance_username" {
  description = "The master username for the database"
  value       = module.rdsdb.db_instance_username
  sensitive   = true
}

output "rdsdb_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.rdsdb.db_instance_password
  sensitive   = true
}

output "rdsdb_instance_port" {
  description = "The database port"
  value       = module.rdsdb.db_instance_port
}

output "rdsdb_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.rdsdb.db_subnet_group_id
}

output "rdsdb_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = module.rdsdb.db_subnet_group_arn
}

output "rdsdb_parameter_group_id" {
  description = "The db parameter group id"
  value       = module.rdsdb.db_parameter_group_id
}

output "rdsdb_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = module.rdsdb.db_parameter_group_arn
}

output "rdsdb_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.rdsdb.db_instance_cloudwatch_log_groups
}