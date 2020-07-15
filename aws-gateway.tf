resource "aws_api_gateway_rest_api" "cmbot_api" {
  name        = "cmbot_api"
  description = "API to call lambda to invoke ML model endpoint"
  tags = local.common_tags
}

resource "aws_api_gateway_resource" "cmbot_api_proxy" {
   rest_api_id = aws_api_gateway_rest_api.cmbot_api.id
   parent_id   = aws_api_gateway_rest_api.cmbot_api.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "cmbot_api_proxy" {
   rest_api_id   = aws_api_gateway_rest_api.cmbot_api.id
   resource_id   = aws_api_gateway_resource.cmbot_api_proxy.id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.cmbot_api.id
   resource_id = aws_api_gateway_method.cmbot_api_proxy.resource_id
   http_method = aws_api_gateway_method.cmbot_api_proxy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.change_prediction.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.cmbot_api.id
   resource_id   = aws_api_gateway_rest_api.cmbot_api.root_resource_id
   http_method   = "ANY"
   authorization = "NONE"
 }

 resource "aws_api_gateway_integration" "lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.cmbot_api.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.change_prediction.invoke_arn
}

resource "aws_api_gateway_deployment" "cmbot_api_deployment" {
   depends_on = [
     aws_api_gateway_integration.lambda,
     aws_api_gateway_integration.lambda_root,
   ]

   rest_api_id = aws_api_gateway_rest_api.cmbot_api.id
   stage_name  = "prod"
}

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.change_prediction.function_name
   principal     = "apigateway.amazonaws.com"
   source_arn = "${aws_api_gateway_rest_api.cmbot_api.execution_arn}/*/*"
 }

output "api_endpoint" {
  value = aws_api_gateway_deployment.cmbot_api_deployment.invoke_url
}
