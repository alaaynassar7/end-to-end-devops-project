# --- API Gateway (HTTP) ---
resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
  tags          = var.tags
}

# --- API Stage ---
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true
  tags        = var.tags
}

# --- VPC Link ---
resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${var.project_name}-vpc-link"
  # Use the passed security group ID
  security_group_ids = [var.security_group_id]
  subnet_ids         = var.private_subnet_ids

  tags = var.tags
}

# --- API Integration ---
resource "aws_apigatewayv2_integration" "ingress_integration" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  # If load_balancer_arn is not ready yet, we use a placeholder to prevent crash
  integration_uri  = var.load_balancer_arn != "" ? var.load_balancer_arn : "http://placeholder"

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.main.id
  payload_format_version = "1.0"
}

# --- Default Route ---
resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.ingress_integration.id}"
}