# ------------------------------------------------------------------------
# 1. HTTP API Gateway (The Entry Point)
# ------------------------------------------------------------------------
resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
  
  # CORS Configuration (Optional but recommended for frontend apps)
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization"]
    max_age       = 300
  }

  tags = var.tags
}

# ------------------------------------------------------------------------
# 2. VPC Link (The Bridge to Private Subnets)
# ------------------------------------------------------------------------
# This is the critical component that allows API Gateway to talk to your
# private EKS Load Balancer without exposing it to the public internet.
resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${var.project_name}-vpc-link"
  security_group_ids = [var.security_group_id]
  subnet_ids         = var.subnet_ids

  tags = var.tags
}

# ------------------------------------------------------------------------
# 3. Default Stage (Auto-Deploy)
# ------------------------------------------------------------------------
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true

  # Enable logging for debugging (Optional)
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn
    format          = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }

  tags = var.tags
}

# Log Group for API Gateway
resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api-gw/${var.project_name}"
  retention_in_days = 7
}

# ------------------------------------------------------------------------
# 4. Integration (Wiring API GW -> VPC Link -> NLB)
# ------------------------------------------------------------------------
# NOTE: This resource requires the Load Balancer ARN (integration_uri).
# During the first run, this might fail if the LB doesn't exist yet.
# We use 'count' to only create it if the URI is provided.
resource "aws_apigatewayv2_integration" "eks_integration" {
  count = var.integration_uri != "" ? 1 : 0

  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  
  # The URI of the internal ALB/NLB Listener
  integration_uri    = var.integration_uri 
  integration_method = "ANY"
  
  connection_type = "VPC_LINK"
  connection_id   = aws_apigatewayv2_vpc_link.main.id
}

# ------------------------------------------------------------------------
# 5. Route (Forwarding Traffic)
# ------------------------------------------------------------------------
resource "aws_apigatewayv2_route" "default_route" {
  count = var.integration_uri != "" ? 1 : 0

  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}" # Catch-all route
  target    = "integrations/${aws_apigatewayv2_integration.eks_integration[0].id}"
}