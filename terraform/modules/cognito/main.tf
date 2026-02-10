resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-user-pool-${var.environment}"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "client" {
  name = "${var.project_name}-client"

  user_pool_id    = aws_cognito_user_pool.main.id
  generate_secret = true

  # Placeholder URL to avoid circular dependency with API Gateway.
  # Update this manually in AWS Console or use a Custom Domain variable if available.
  callback_urls = ["http://localhost:3000/callback"]
  logout_urls   = ["http://localhost:3000/logout"]

  supported_identity_providers = ["COGNITO"]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

resource "aws_cognito_user_pool_domain" "main" {
  # Domain must be globally unique, so we append environment and a random string if needed
  # Using project_name-environment is usually safe for unique project names
  domain       = "${var.project_name}-${var.environment}-auth"
  user_pool_id = aws_cognito_user_pool.main.id
}