resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
  tags          = var.tags
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true
}

# 1. Authorizer (Secure the API with Cognito)
resource "aws_apigatewayv2_authorizer" "main" {
  api_id           = aws_apigatewayv2_api.main.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [var.cognito_client_id]
    issuer   = "https://${var.cognito_endpoint}"
  }
}

# 2. Integration (Connect to Load Balancer)
resource "aws_apigatewayv2_integration" "main" {
  api_id             = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = var.integration_uri 
  
  # --- CHANGE HERE ---
  # Changed from "ANY" to "POST" because HTTP_PROXY over INTERNET requires a specific verb
  integration_method = "POST"
  # -------------------

  connection_type    = "INTERNET"
}
# 3. Route (Forward traffic)
resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.main.id}"
  
  # Authorization attached here
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.main.id
}