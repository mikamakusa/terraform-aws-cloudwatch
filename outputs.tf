## Logs ##

output "log_group_arn" {
  value = try(
    aws_cloudwatch_log_group.this.*.arn
  )
}