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
  tags        = var.tags
}

# --- VPC Link ---
# Enables the API Gateway to communicate with resources inside the private subnets
resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${var.project_name}-vpc-link"
  # Uses the passed security group ID (Fixed: ensure this is a list)
  security_group_ids = [var.security_group_id]
  subnet_ids         = var.private_subnet_ids

  tags = var.tags
}

# --- API Integration ---
# Routes traffic from the Gateway to the Private Load Balancer via VPC Link
# Conditional creation: Only creates this resource if load_balancer_arn is provided
resource "aws_apigatewayv2_integration" "ingress_integration" {
  count = var.load_balancer_arn == "" ? 0 : 1

  api_id             = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = var.load_balancer_arn
  integration_method = "ANY"
  
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.main.id
  payload_format_version = "1.0"
}

# --- Default Route ---
# Catches all traffic and directs it to the Ingress Integration
# Conditional creation: Only creates this route if the integration exists
resource "aws_apigatewayv2_route" "default_route" {
  count = var.load_balancer_arn == "" ? 0 : 1

  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  
  # References the first instance of the integration created by count [0]
  target    = "integrations/${aws_apigatewayv2_integration.ingress_integration[0].id}"
}