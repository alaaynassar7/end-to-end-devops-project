# --- API Gateway (HTTP) ---
# Defines the HTTP API Gateway as the primary entry point
resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
  tags          = var.tags
}

# --- API Stage ---
# Configures the default stage for automatic deployments
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true

  tags = var.tags
}

# --- VPC Link ---
# Enables the API Gateway to communicate with resources inside the private subnets
resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${var.project_name}-vpc-link"
  security_group_ids = [var.security_group_id]
  subnet_ids         = var.private_subnet_ids

  tags = var.tags
}

# --- API Integration ---
# Routes traffic from the Gateway to the Private Load Balancer via VPC Link
resource "aws_apigatewayv2_integration" "ingress_integration" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  integration_uri  = var.load_balancer_arn # This will be the Internal NLB created by Ingress

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.main.id
}

# --- Default Route ---
# Catches all traffic and directs it to the Ingress Integration
resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.ingress_integration.id}"
}