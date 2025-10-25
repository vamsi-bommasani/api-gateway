# ======================================================
# AWS
# ======================================================

variable "aws_region" {
  description = "provide the aws_region"
  type        = string
}

# ======================================================
# Tags
# ======================================================

variable "app_id" {
  description = "provide an app-id"
  type        = string
}

variable "environment" {
  description = "provide some environment name"
  type        = string
}

variable "engineer_mail" {
  description = "provide an email to send mails"
  type        = string
}

# ======================================================
# API Keys && Usage Plan
# ======================================================

variable "rate_limit" {
  description = "The API request steady-state rate limit"
  type        = number
}

variable "burst_limit" {
  description = "The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity"
  type        = number
}

variable "quota_limit" {
  description = "Maximum number of requests that can be made in a given time period"
  type        = number
}

variable "quota_period" {
  description = "Time period in which the limit applies. Valid values are \"DAY\", \"WEEK\" or \"MONTH\""
  type        = string
}
