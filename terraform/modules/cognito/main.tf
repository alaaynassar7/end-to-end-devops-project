# ------------------------------------------------------------------------
# 1. Cognito User Pool (User Directory)
# ------------------------------------------------------------------------
resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-user-pool"

  # Enforce strong password policies
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  # Use email as the username
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  # Multi-Factor Authentication (Optional - Disabled for simplicity)
  mfa_configuration = "OFF"

  tags = var.tags
}

# ------------------------------------------------------------------------
# 2. User Pool Client (App Integration)
# ------------------------------------------------------------------------
resource "aws_cognito_user_pool_client" "client" {
  name = "${var.project_name}-app-client"

  user_pool_id = aws_cognito_user_pool.main.id

  # Generate Secret: Set to FALSE for SPAs (React/Angular) or Mobile Apps
  # Set to TRUE if using a backend server to handle auth
  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}

# ------------------------------------------------------------------------
# 3. User Pool Domain (Hosted UI)
# ------------------------------------------------------------------------
resource "aws_cognito_user_pool_domain" "main" {
  # Domain prefix must be globally unique
  domain       = "${var.project_name}-auth-${random_id.suffix.hex}"
  user_pool_id = aws_cognito_user_pool.main.id
}

# Random suffix to ensure domain uniqueness
resource "random_id" "suffix" {
  byte_length = 4
}

# ------------------------------------------------------------------------
# 4. API Gateway Authorizer (Security Gate)
# ------------------------------------------------------------------------
# Connects Cognito to API Gateway to validate JWT tokens automatically
resource "aws_apigatewayv2_authorizer" "main" {
  api_id           = var.api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "${var.project_name}-cognito-authorizer"

  jwt_configuration {
    audience = [aws_cognito_user_pool_client.client.id]
    issuer   = "https://${aws_cognito_user_pool.main.endpoint}"
  }
}