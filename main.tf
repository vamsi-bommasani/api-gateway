resource "aws_api_gateway_rest_api" "gateway" {
  name        = "${var.aws_region}-${var.environment}-ApiGw"
  description = "Secure API Gateway for personal use"
}

resource "aws_api_gateway_method" "get_root" {
  rest_api_id      = aws_api_gateway_rest_api.gateway.id
  resource_id      = data.aws_api_gateway_resource.root.id
  http_method      = "GET"
  authorization    = "AWS_IAM"
  api_key_required = true
}

resource "aws_api_gateway_method" "post_root" {
  rest_api_id   = aws_api_gateway_rest_api.gateway.id
  resource_id   = data.aws_api_gateway_resource.root.id
  http_method   = "POST"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.get_root.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.post_root.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_method_response" "get_response_200" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.get_root.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "post_response_200" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.post_root.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.get_root.http_method
  status_code = aws_api_gateway_method_response.get_response_200.status_code

  response_templates = {
    "application/json" = jsonencode({
      message = "GET request successful"
    })
  }
}

resource "aws_api_gateway_integration_response" "post_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.post_root.http_method
  status_code = aws_api_gateway_method_response.post_response_200.status_code

  response_templates = {
    "application/json" = jsonencode({
      message = "POST request successful"
    })
  }
}

resource "aws_api_gateway_deployment" "personal_api_deploy" {
  depends_on = [
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_integration_response.get_integration_response,
    aws_api_gateway_integration_response.post_integration_response
  ]
  rest_api_id = aws_api_gateway_rest_api.gateway.id
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.personal_api_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.gateway.id
  stage_name    = "prod"
}

resource "aws_api_gateway_api_key" "api_key" {
  name        = "${var.aws_region}-${var.environment}-apikey"
  description = "API Key for ${var.aws_region}-${var.environment}-ApiGw"
  enabled     = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name        = "${var.aws_region}-${var.environment}-usageplan"
  description = "Usage Plan for ${var.aws_region}-${var.environment}-ApiGw"

  api_stages {
    api_id = aws_api_gateway_rest_api.gateway.id
    stage  = aws_api_gateway_stage.prod.stage_name
  }

  quota_settings {
    limit  = var.quota_limit
    period = var.quota_period
  }

  throttle_settings {
    burst_limit = var.burst_limit
    rate_limit  = var.rate_limit
  }
}

resource "aws_api_gateway_usage_plan_key" "association" {
  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}
