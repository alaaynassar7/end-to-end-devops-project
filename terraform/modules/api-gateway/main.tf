# 1. REST API Definition
resource "aws_api_gateway_rest_api" "main" {
  name = "${var.project_name}-api"
}

# 2. VPC Link (استخدام النوع ده بيحل مشكلة الـ NLB ARN)
resource "aws_api_gateway_vpc_link" "eks" {
  name        = "${var.project_name}-vpc-link"
  target_arns = [var.node_sg_arn] 
}
# 3. Resource & Method
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

# 4. Integration
resource "aws_api_gateway_integration" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.any.http_method
  
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "${var.integration_uri}/{proxy}"
  
  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.eks.id
}

# 5. Deployment & Stage
resource "aws_api_gateway_deployment" "main" {
  depends_on  = [aws_api_gateway_integration.main]
  rest_api_id = aws_api_gateway_rest_api.main.id
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = "prod"
}