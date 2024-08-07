## Cloudwatch ##

output "composite_alarm_id" {
  value = try(
    aws_cloudwatch_composite_alarm.this.*.id
  )
}

output "composite_alarm_arn" {
  value = try(
    aws_cloudwatch_composite_alarm.this.*.arn
  )
}

output "dashboard_id" {
  value = try(
    aws_cloudwatch_dashboard.this.*.id
  )
}

output "dashboard_arn" {
  value = try(aws_cloudwatch_dashboard.this.*.dashboard_arn)
}

output "dashboard_name" {
  value = try(
    aws_cloudwatch_dashboard.this.*.dashboard_name
  )
}

output "metric_alarm_id" {
  value = try(
    aws_cloudwatch_metric_alarm.this.*.id
  )
}

output "metric_alarm_arn" {
  value = try(
    aws_cloudwatch_metric_alarm.this.*.arn
  )
}

output "metric_stream_id" {
  value = try(
    aws_cloudwatch_metric_stream.this.*.id
  )
}

output "metric_stream_name" {
  value = try(
    aws_cloudwatch_metric_stream.this.*.name
  )
}

output "metric_stream_arn" {
  value = try(
    aws_cloudwatch_metric_stream.this.*.arn
  )
}

## Application Insights ##

output "application_insight_id" {
  value = try(
    aws_applicationinsights_application.this.*.id
  )
}

output "application_insight_arn" {
  value = try(
    aws_applicationinsights_application.this.*.arn
  )
}

## Evidently ##

output "evidently_feature_id" {
  value = try(
    aws_evidently_feature.this.*.id
  )
}

output "evidently_feature_name" {
  value = try(
    aws_evidently_feature.this.*.name
  )
}

output "evidently_feature_arn" {
  value = try(
    aws_evidently_feature.this.*.arn
  )
}

output "evidently_project_id" {
  value = try(
    aws_evidently_project.this.*.id
  )
}

output "evidently_project_name" {
  value = try(
    aws_evidently_project.this.*.name
  )
}

output "evidently_project_arn" {
  value = try(
    aws_evidently_project.this.*.arn
  )
}

output "evidently_segment_id" {
  value = try(
    aws_evidently_segment.this.*.id
  )
}

output "evidently_segment_name" {
  value = try(
    aws_evidently_segment.this.*.name
  )
}

output "evidently_segment_arn" {
  value = try(
    aws_evidently_segment.this.*.arn
  )
}

## Internet Monitor ##

output "internet_monitor_id" {
  value = try(
    aws_internetmonitor_monitor.this.*.id
  )
}

output "internet_monitor_name" {
  value = try(
    aws_internetmonitor_monitor.this.*.monitor_name
  )
}

## Logs ##

output "log_account_policy_id" {
  value = try(
    aws_cloudwatch_log_account_policy.this.*.id
  )
}

output "log_data_protection_policy_id" {
  value = try(
    aws_cloudwatch_log_data_protection_policy.this.*.id
  )
}

output "log_destination_id" {
  value = try(
    aws_cloudwatch_log_destination.this.*.id
  )
}

output "log_destination_arn" {
  value = try(
    aws_cloudwatch_log_destination.this.*.arn
  )
}

output "log_group_arn" {
  value = try(
    aws_cloudwatch_log_group.this.*.arn
  )
}

output "log_group_id" {
  value = try(
    aws_cloudwatch_log_group.this.*.id
  )
}

output "log_metric_filter_id" {
  value = try(
    aws_cloudwatch_log_metric_filter.this.*.id
  )
}

output "log_resource_policy_id" {
  value = try(
    aws_cloudwatch_log_resource_policy.this.*.id
  )
}

output "log_stream_id" {
  value = try(
    aws_cloudwatch_log_stream.this.*.id
  )
}

output "log_stream_arn" {
  value = try(
    aws_cloudwatch_log_stream.this.*.arn
  )
}

output "log_subscription_filter_id" {
  value = try(
    aws_cloudwatch_log_subscription_filter.this.*.id
  )
}

output "query_definition_id" {
  value = try(
    aws_cloudwatch_query_definition.this.*.id
  )
}

## Network Monitor ##

output "network_monitor_id" {
  value = try(
    aws_networkmonitor_monitor.this.*.id
  )
}

output "network_monitor_name" {
  value = try(
    aws_networkmonitor_monitor.this.*.monitor_name
  )
}

output "network_monitor_probe_id" {
  value = try(
    aws_networkmonitor_probe.this.*.id
  )
}

## Observability Access Manager ##

output "oam_link_id" {
  value = try(
    aws_oam_link.this.*.id
  )
}

output "oam_sink_id" {
  value = try(
    aws_oam_sink.this.*.id
  )
}

output "oam_sink_policy_id" {
  value = try(
    aws_oam_sink_policy.this.*.id
  )
}

## RUM ##

output "rum_app_monitor_id" {
  value = try(
    aws_rum_app_monitor.this.*.id
  )
}

output "rum_app_monitor_name" {
  value = try(
    aws_rum_app_monitor.this.*.name
  )
}

output "rum_app_monitor_arn" {
  value = try(
    aws_rum_app_monitor.this.*.arn
  )
}

output "rum_metrics_destination_id" {
  value = try(
    aws_rum_metrics_destination.this.*.id
  )
}

## Synthetics ##

output "synthetics_canary_id" {
  value = try(
    aws_synthetics_canary.this.*.id
  )
}

output "synthetics_canary_arn" {
  value = try(
    aws_synthetics_canary.this.*.arn
  )
}

output "synthetics_canary_name" {
  value = try(
    aws_synthetics_canary.this.*.name
  )
}

## Event ##

output "event_api_destination_name" {
  value = try(
    aws_cloudwatch_event_api_destination.this.*.name
  )
}

output "event_api_destination_id" {
  value = try(
    aws_cloudwatch_event_api_destination.this.*.id
  )
}

output "event_api_destination_arn" {
  value = try(
    aws_cloudwatch_event_api_destination.this.*.arn
  )
}

output "event_archive_name" {
  value = try(
    aws_cloudwatch_event_archive.this.*.name
  )
}

output "event_archive_id" {
  value = try(
    aws_cloudwatch_event_archive.this.*.id
  )
}

output "event_archive_arn" {
  value = try(
    aws_cloudwatch_event_archive.this.*.arn
  )
}