resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "main" {
  api_id           = aws_apigatewayv2_api.main.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "alaa-devops-project-authorizer"

  jwt_configuration {
    audience = [var.client_id]
    issuer   = "https://cognito-idp.${var.region}.amazonaws.com/${var.user_pool_id}"
  }
}

resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${var.project_name}-vpc-link"
  security_group_ids = [var.vpc_link_security_group_id]
  subnet_ids         = var.private_subnet_ids
}

resource "aws_apigatewayv2_integration" "main" {
  count = length(regexall("^arn:aws:elasticloadbalancing", var.integration_uri)) > 0 ? 1 : 0

  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  
  integration_method = "ANY"
  
  # We don't need complex conditions here because we only enter this block if we have an ARN
  connection_type    = "VPC_LINK"
  integration_uri    = var.integration_uri
  connection_id      = aws_apigatewayv2_vpc_link.main.id
  
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_route" "main" {
  # Same logic: Do not create the route if there is no Integration
  count = length(regexall("^arn:aws:elasticloadbalancing", var.integration_uri)) > 0 ? 1 : 0

  api_id             = aws_apigatewayv2_api.main.id
  route_key          = "ANY /{proxy+}"
  
  # ⚠️ Important: We must use [0] because count turns this into a List
  target             = "integrations/${aws_apigatewayv2_integration.main[0].id}"
  
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.main.id
}

resource "aws_apigatewayv2_stage" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true
}