# Terraform AWS RHD API Keys

* Create, maintain, and secure APIs at any scale

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_api_key.api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_deployment.personal_api_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.get_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.post_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration_response.get_integration_response](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_integration_response.post_integration_response](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_method.get_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.post_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method_response.get_response_200](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_method_response.post_response_200](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_rest_api.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.prod](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_api_gateway_usage_plan.usage_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan_key.association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_api_gateway_resource.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/api_gateway_resource) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | provide an app-id | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | provide the aws\_region | `string` | n/a | yes |
| <a name="input_burst_limit"></a> [burst\_limit](#input\_burst\_limit) | The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity | `number` | n/a | yes |
| <a name="input_engineer_mail"></a> [engineer\_mail](#input\_engineer\_mail) | provide an email to send mails | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | provide some environment name | `string` | n/a | yes |
| <a name="input_quota_limit"></a> [quota\_limit](#input\_quota\_limit) | Maximum number of requests that can be made in a given time period | `number` | n/a | yes |
| <a name="input_quota_period"></a> [quota\_period](#input\_quota\_period) | Time period in which the limit applies. Valid values are "DAY", "WEEK" or "MONTH" | `string` | n/a | yes |
| <a name="input_rate_limit"></a> [rate\_limit](#input\_rate\_limit) | The API request steady-state rate limit | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_invoke_url"></a> [api\_invoke\_url](#output\_api\_invoke\_url) | n/a |
| <a name="output_api_key_name"></a> [api\_key\_name](#output\_api\_key\_name) | value of the api key name |
| <a name="output_burst_limit"></a> [burst\_limit](#output\_burst\_limit) | The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity |
| <a name="output_quota_limit"></a> [quota\_limit](#output\_quota\_limit) | Maximum number of requests that can be made in a given time period |
| <a name="output_quota_period"></a> [quota\_period](#output\_quota\_period) | Time period in which the limit applies. Valid values are "DAY", "WEEK" or "MONTH" |
| <a name="output_rate_limit"></a> [rate\_limit](#output\_rate\_limit) | The API request steady-state rate limit |
| <a name="output_usage_plan_name"></a> [usage\_plan\_name](#output\_usage\_plan\_name) | value of the usage plan name |
<!-- END_TF_DOCS -->

<!-- Terratest Executions -->
To run the infrastructure tests using Terratest, follow these steps:

1. Make sure you have Go installed on your system
2. Navigate to the terratests directory:
   ```bash
   cd terratests/
   ```

3. Download required Go dependencies:
   ```bash
   go mod tidy
   ```

4. Run the tests:
   ```bash
   go test -v
   ```

Note: Make sure you have valid AWS credentials configured before running the tests. The tests will create real AWS resources in your account for validation.
<!-- END Terratest Executions-->
