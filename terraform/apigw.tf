#api-gateway
resource "aws_api_gateway_rest_api" "portfolio" {
  name = "portfolio-api"
}

resource "aws_api_gateway_resource" "track" {
  rest_api_id = aws_api_gateway_rest_api.portfolio.id
  parent_id   = aws_api_gateway_rest_api.portfolio.root_resource_id
  path_part   = "track"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio.id
  resource_id   = aws_api_gateway_resource.track.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.portfolio.id
  resource_id = aws_api_gateway_resource.track.id
  http_method = aws_api_gateway_method.post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.tracker.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tracker.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.portfolio.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = aws_api_gateway_rest_api.portfolio.id
  depends_on = [aws_api_gateway_integration.lambda]
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "production"
  rest_api_id   = aws_api_gateway_rest_api.portfolio.id
  deployment_id = aws_api_gateway_deployment.deploy.id
}