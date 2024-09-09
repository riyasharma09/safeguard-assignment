# CloudTrail Setup
resource "aws_cloudtrail" "trail" {
  name                          = var.trail_name
  s3_bucket_name                = var.cloudtrail_s3_bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = var.tags
}

# VPC Flow Logs Setup
resource "aws_cloudwatch_log_group" "vpc_flow_log_group" {
  name              = "${var.log_group_prefix}/vpc/flow"
  retention_in_days = var.log_retention_in_days
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_log_group.arn
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
  log_destination_type = "cloud-watch-logs"

  tags = var.tags
}

# AWS Config Setup
resource "aws_config_configuration_recorder" "config_recorder" {
  name     = var.config_recorder_name
  role_arn = var.config_role_arn
  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }

  
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = var.config_delivery_channel_name
  s3_bucket_name = var.config_s3_bucket

 
}

resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = aws_config_configuration_recorder.config_recorder.name  # Use "name" instead of "recorder_name"
  is_enabled = true  # Ensure the configuration recorder is enabled
}


# Example AWS Config Rule for S3 Encryption
resource "aws_config_config_rule" "s3_encryption_enabled" {
  name = "s3-bucket-encryption-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  tags = var.tags
}

# CloudWatch Alarms (For Unauthorized Access)
resource "aws_cloudwatch_metric_alarm" "unauthorized_access_alarm" {
  alarm_name          = var.unauthorized_access_alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnauthorizedAccess"
  namespace           = "AWS/CloudTrail"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [var.sns_topic_arn]

  tags = var.tags
}
