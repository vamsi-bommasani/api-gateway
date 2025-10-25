output "api_key_name" {
  value       = aws_api_gateway_api_key.api_key.name
  description = "value of the api key name"
}

output "usage_plan_name" {
  value       = aws_api_gateway_usage_plan.usage_plan.name
  description = "value of the usage plan name"
}

output "rate_limit" {
  description = "The API request steady-state rate limit"
  value       = var.rate_limit
}

output "burst_limit" {
  description = "The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity"
  value       = var.burst_limit
}

output "quota_limit" {
  description = "Maximum number of requests that can be made in a given time period"
  value       = var.quota_limit
}

output "quota_period" {
  description = "Time period in which the limit applies. Valid values are \"DAY\", \"WEEK\" or \"MONTH\""
  value       = var.quota_period
}

output "api_invoke_url" {
  value = aws_api_gateway_stage.prod.invoke_url
}
