variable "tags" {
  type    = map(string)
  default = {}
}

variable "networkmonitor_probe_source_arn" {
  type    = string
  default = null
}

variable "synthetics_canary_s3_encrpytion_kms_key_arn" {
  type    = string
  default = null
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "resource_group_name" {
  type = string
  default = null
}

variable "composite_alarm" {
  type = list(map(object({
    id                        = number
    alarm_name                = string
    alarm_rule                = string
    actions_enabled           = optional(bool)
    alarm_actions             = optional(set(string))
    alarm_description         = optional(string)
    insufficient_data_actions = optional(set(string))
    ok_actions                = optional(set(string))
    tags                      = optional(map(string))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "dashboard" {
  type = list(map(object({
    id             = number
    dashboard_body = string
    dashboard_name = string
  })))
  default     = []
  description = <<EOF
EOF
}

variable "metric_alarm" {
  type = list(map(object({
    id                                    = number
    alarm_id                              = number
    comparison_operator                   = string
    evaluation_periods                    = number
    metric_name                           = optional(string)
    namespace                             = optional(string)
    period                                = optional(number)
    statistic                             = optional(string)
    threshold                             = optional(number)
    threshold_metric_id                   = optional(string)
    actions_enabled                       = optional(bool)
    alarm_actions                         = optional(set(string))
    alarm_description                     = optional(string)
    datapoints_to_alarm                   = optional(number)
    dimensions                            = optional(map(string))
    insufficient_data_actions             = optional(set(string))
    ok_actions                            = optional(set(string))
    unit                                  = optional(string)
    extended_statistic                    = optional(string)
    treat_missing_data                    = optional(string)
    evaluate_low_sample_count_percentiles = optional(string)
    tags                                  = optional(map(string))
    metric_query = optional(list(object({
      id          = string
      account_id  = optional(string)
      expression  = optional(string)
      label       = optional(string)
      period      = optional(string)
      return_data = optional(bool)
      metric = optional(list(object({
        metric_name = string
        period      = number
        stat        = string
        namespace   = string
        dimensions  = optional(map(string))
        unit        = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
EOF

  validation {
    condition = length([
      for a in var.metric_alarm : true if contains(["GreaterThanOrEqualToThreshold", "GreaterThanThreshold", "LessThanThreshold", "LessThanOrEqualToThreshold"], a.comparison_operator)
    ]) == length(var.metric_alarm)
    error_message = "Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. Additionally, the values LessThanLowerOrGreaterThanUpperThreshold, LessThanLowerThreshold, and GreaterThanUpperThreshold are used only for alarms based on anomaly detection models."
  }

  validation {
    condition = length([
      for b in var.metric_alarm : true if contains(["SampleCount", "Average", "Sum", "Minimum", "Maximum"], b.statistic)
    ]) == length(var.metric_alarm)
    error_message = "Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum."
  }

  validation {
    condition = length([
      for c in var.metric_alarm : true if contains(["missing", "ignore", "breaching", "notBreaching."], c.treat_missing_data)
    ]) == length(var.metric_alarm)
    error_message = "Either of the following is supported: missing, ignore, breaching and notBreaching."
  }
}

variable "metric_stream" {
  type = list(map(object({
    id            = number
    firehose_arn  = string
    output_format = string
    role_arn      = string
    name          = optional(string)
    name_prefix   = optional(string)
    tags          = optional(map(string))
    include_filter = optional(list(object({
      namespace = optional(string)
    })), [])
    exclude_filter = optional(list(object({
      namespace = optional(string)
    })), [])
    statistics_configuration = optional(list(object({
      additional_statistics = set(string)
      include_metric = list(object({
        metric_name = string
        namespace   = string
      }))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF

  validation {
    condition = length([
      for a in var.metric_stream : true if contains(["json", "opentelemetry0.7", "opentelemetry1.0"], a.output_format)
    ]) == length(var.metric_stream)
    error_message = "Possible values are json, opentelemetry0.7, and opentelemetry1.0."
  }
}

variable "applicationinsights" {
  type = list(map(object({
    id                     = number
    auto_config_enabled    = optional(bool)
    auto_create            = optional(bool)
    cwe_monitor_enabled    = optional(bool)
    grouping_type          = optional(string)
    ops_center_enabled     = optional(bool)
    ops_item_sns_topic_arn = optional(string)
    tags                   = optional(map(string))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "evidently_feature" {
  type = list(map(object({
    id                  = number
    name                = string
    project_id          = number
    default_variation   = optional(string)
    description         = optional(string)
    entity_overrides    = optional(map(string))
    evaluation_strategy = optional(string)
    tags                = optional(map(string))
    variations = optional(list(object({
      name = string
      variations = list(object({
        bool_value   = string
        double_value = string
        long_value   = string
        string_value = string
      }))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "evidently_project" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
    data_delivery = optional(list(object({
      cloudwatch_logs = optional(list(object({
        log_group = optional(string)
      })), [])
      s3_destination = optional(list(object({
        bucket = optional(string)
        prefix = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "evidently_segment" {
  type = list(map(object({
    id          = number
    name        = string
    pattern     = string
    description = optional(string)
    tags        = optional(map(string))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "log_account_policy" {
  type = list(object({
    id                 = number
    policy_document    = string
    policy_type        = string
    policy_name        = string
    scope              = optional(string)
    selection_criteria = optional(string)
  }))
  default = []

  validation {
    condition = length([
      for a in var.log_account_policy : true if contains(["DATA_PROTECTION_POLICY", "SUBSCRIPTION_FILTER_POLICY"], a.policy_type)
    ]) == length(var.log_account_policy)
    error_message = " Either DATA_PROTECTION_POLICY or SUBSCRIPTION_FILTER_POLICY. You can have one account policy per type in an account."
  }
}

variable "log_data_protection_policy" {
  type = list(map(object({
    id              = number
    log_group_id    = number
    policy_document = string
  })))
  default     = []
  description = <<EOF
EOF
}

variable "log_destination" {
  type = list(map(object({
    id         = number
    name       = string
    role_arn   = string
    target_arn = string
  })))
  default     = []
  description = <<EOF
EOF
}

variable "log_destination_policy" {
  type = list(map(object({
    id               = number
    access_policy    = string
    destination_name = string
  })))
  default = []
}

variable "log_group" {
  type = list(map(object({
    id                = number
    name              = optional(string)
    name_prefix       = optional(string)
    skip_destroy      = optional(bool)
    retention_in_days = optional(number)
    kms_key_id        = optional(string)
    tags              = optional(map(string))
    log_group_class   = optional(string)
  })))
  default = []

  validation {
    condition = length([
      for a in var.log_group : true if contains(["STANDARD", "INFREQUENT_ACCESS"], a.log_group_class)
    ]) == length(var.log_group)
    error_message = "Either DATA_PROTECTION_POLICY or SUBSCRIPTION_FILTER_POLICY. You can have one account policy per type in an account."
  }
}

variable "log_metric_filter" {
  type = list(map(object({
    id           = number
    log_group_id = number
    name         = string
    pattern      = string
    metric_transformation = list(object({
      name          = string
      namespace     = string
      value         = string
      default_value = optional(string)
    }))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_resource_policy" {
  type = list(map(object({
    id              = number
    policy_document = string
    policy_name     = string
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_stream" {
  type = list(map(object({
    id           = number
    log_group_id = number
    name         = string
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_subscription_filter" {
  type = list(map(object({
    id              = number
    destination_arn = string
    filter_pattern  = string
    log_group_id    = number
    name            = string
    role_arn        = optional(string)
    distribution    = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "query_definition" {
  type = list(map(object({
    id           = number
    name         = string
    query_string = string
    log_group_id = optional(list(number))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "rum_app_monitor" {
  type = list(map(object({
    id             = number
    domain         = string
    name           = string
    cw_log_enabled = optional(bool)
    tags           = optional(map(string))
    app_monitor_configuration = optional(list(object({
      allow_cookies       = optional(bool)
      enable_xray         = optional(bool)
      excluded_pages      = optional(set(string))
      favorite_pages      = optional(set(string))
      guest_role_arn      = optional(string)
      identity_pool_id    = optional(string)
      included_pages      = optional(set(string))
      session_sample_rate = optional(number)
      telemetries         = optional(set(string))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "rum_metrics_destination" {
  type = list(map(object({
    id              = number
    app_monitor_id  = number
    destination     = string
    destination_arn = optional(string)
    iam_role_arn    = optional(string)
  })))
  default     = []

  validation {
    condition = length([
      for a in var.rum_metrics_destination : true if contains(["Cloudwatch", "Evidently"], a.destination)
    ]) == length(var.log_group)
    error_message = "Valid values are CloudWatch and Evidently. If you specify Evidently, you must also specify the ARN of the CloudWatchEvidently experiment that is to be the destination and an IAM role that has permission to write to the experiment."
  }
}

variable "synthetics_canary" {
  type = list(map(object({
    id                       = number
    artifact_s3_location     = string
    execution_role_arn       = any
    handler                  = string
    name                     = string
    runtime_version          = string
    delete_lambda            = optional(bool)
    s3_bucket                = optional(any)
    s3_key                   = optional(string)
    s3_version               = optional(string)
    start_canary             = optional(bool)
    success_retention_period = optional(number)
    tags                     = optional(map(string))
    zip_file                 = optional(string)
    schedule = list(object({
      expression          = string
      duration_in_seconds = optional(number)
    }))
    artifact_config = optional(list(object({
      s3_encryption = optional(list(object({
        encryption_mode = optional(string)
        kms_key_arn     = optional(any)
      })))
    })))
    run_config = optional(list(object({
      timeout_in_seconds    = optional(number)
      memory_in_mb          = optional(number)
      active_tracing        = optional(bool)
      environment_variables = optional(map(string))
    })))
    vpc_config = optional(list(object({
      subnet_ids         = optional(set(any))
      security_group_ids = optional(set(any))
    })))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_api_destination" {
  type = list(map(object({
    id                               = number
    connection_arn                   = string
    http_method                      = string
    invocation_endpoint              = string
    name                             = string
    invocation_rate_limit_per_second = optional(number)
    description                      = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_archive" {
  type = list(map(object({
    id               = number
    event_source_arn = string
    name             = string
    description      = optional(string)
    event_pattern    = optional(string)
    retention_days   = optional(number)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_bus" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_bus_policy" {
  type = list(map(object({
    id           = number
    policy       = string
    event_bus_id = optional(number)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_connection" {
  type = list(map(object({
    id                 = number
    authorization_type = string
    name               = string
    description        = optional(string)
    auth_parameters = list(object({
      api_key = optional(list(object({
        key   = string
        value = string
      })), [])
      basic = optional(list(object({
        password = string
        username = string
      })))
      invocation_http_parameters = optional(list(object({
        body = optional(list(object({
          key             = optional(string)
          value           = optional(string)
          is_value_secret = optional(bool)
        })), [])
        header = optional(list(object({
          key             = optional(string)
          value           = optional(string)
          is_value_secret = optional(bool)
        })), [])
        query_string = optional(list(object({
          key             = optional(string)
          value           = optional(string)
          is_value_secret = optional(bool)
        })), [])
      })), [])
      oauth = optional(list(object({
        authorization_endpoint = string
        http_method            = string
        client_parameters = optional(list(object({
          client_id     = string
          client_secret = string
        })), [])
        oauth_http_parameters = optional(list(object({
          body = optional(list(object({
            key             = optional(string)
            value           = optional(string)
            is_value_secret = optional(bool)
          })), [])
          header = optional(list(object({
            key             = optional(string)
            value           = optional(string)
            is_value_secret = optional(bool)
          })), [])
          query_string = optional(list(object({
            key             = optional(string)
            value           = optional(string)
            is_value_secret = optional(bool)
          })), [])
        })), [])
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_permission" {
  type = list(map(object({
    id           = number
    principal    = string
    statement_id = string
    action       = optional(string)
    event_bus_id = optional(number)
    condition = optional(list(object({
      key   = string
      type  = string
      value = string
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_rule" {
  type = list(map(object({
    id                  = number
    name                = optional(string)
    name_prefix         = optional(string)
    schedule_expression = optional(string)
    event_bus_name      = optional(number)
    event_pattern       = optional(string)
    description         = optional(string)
    role_arn            = optional(string)
    is_enabled          = optional(bool)
    state               = optional(string)
    tags                = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_target" {
  type = list(map(object({
    id           = number
    arn          = string
    rule_id      = number
    event_bus_id = optional(number)
    input        = optional(string)
    input_path   = optional(string)
    role_arn     = optional(string)
    target_id    = optional(string)
    batch_target = optional(list(object({
      job_definition = string
      job_name       = string
      array_size     = optional(number)
      job_attempts   = optional(number)
    })), [])
    dead_letter_config = optional(list(object({
      arn = optional(string)
    })), [])
    ecs_target = optional(list(object({
      task_definition_arn = string
      launch_type         = optional(string)
      platform_version    = optional(string)
      task_count          = optional(number)
    })), [])
    input_transformer = optional(list(object({
      input_template = string
      input_paths    = optional(map(string))
    })), [])
    kinesis_target = optional(list(object({
      partition_key_path = optional(string)
    })), [])
    run_command_targets = optional(list(object({
      key    = string
      values = set(string)
    })), [])
    retry_policy = optional(list(object({
      maximum_event_age_in_seconds = optional(number)
      maximum_retry_attempts       = optional(number)
    })), [])
    sqs_target = optional(list(object({
      message_group_id = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "internetmonitor" {
  type = list(object({
    id                            = number
    monitor_name                  = string
    max_city_networks_to_monitor  = optional(number)
    resources                     = optional(set(string))
    status                        = optional(string)
    tags                          = optional(map(string))
    traffic_percentage_to_monitor = optional(number)
    health_events_config = optional(list(object({
      availability_score_threshold = optional(number)
      performance_score_threshold  = optional(number)
    })))
    internet_measurements_log_delivery = optional(list(object({})))
  }))
  default = []

  validation {
    condition = length([
      for a in var.internetmonitor : true if contains(["ACTIVE", "INACTIVE"], a.status)
    ]) == length(var.metric_stream)
    error_message = "Possible values are ACTIVE and INACTIVE."
  }
}

variable "networkmonitor_monitor" {
  type = list(object({
    id                 = number
    monitor_name       = string
    aggregation_period = optional(number)
    tags               = optional(map(string))
  }))
  default = []
}

variable "networkmonitor_probe" {
  type = list(object({
    id               = number
    destination      = string
    destination_port = number
    monitor_id       = any
    protocol         = string
    source_id        = any
    packet_size      = number
    tags             = optional(map(string))
  }))
  default = []
}

variable "oam_link" {
  type = list(object({
    id             = number
    label_template = string
    resource_types = list(string)
    sink_id        = any
    tags           = optional(map(string))
    link_configuration = optional(list(object({
      log_group_configuration = optional(list(object({
        filter = optional(string)
      })))
      metric_configuration = optional(list(object({
        filter = optional(string)
      })))
    })))
  }))
  default = []
}

variable "oam_sink" {
  type = list(object({
    id   = number
    name = string
    tags = optional(map(string))
  }))
  default = []
}

variable "oam_sink_policy" {
  type = list(object({
    id      = number
    sink_id = any
    policy  = string
  }))
  default = []
}