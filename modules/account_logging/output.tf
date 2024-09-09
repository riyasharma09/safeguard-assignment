output "cloudtrail_arn" {
  description = "The ARN of the CloudTrail"
  value       = aws_cloudtrail.trail.arn
}

output "vpc_flow_log_group_arn" {
  description = "The ARN of the CloudWatch log group for VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow_log_group.arn
}

output "config_recorder_status" {
  description = "AWS Config recorder status"
  value       = aws_config_configuration_recorder_status.config_recorder_status.is_enabled
}

output "unauthorized_access_alarm_arn" {
  description = "The ARN of the CloudWatch alarm for unauthorized access"
  value       = aws_cloudwatch_metric_alarm.unauthorized_access_alarm.arn
}
