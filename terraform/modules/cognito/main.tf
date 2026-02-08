resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-user-pool"
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "app-client"
  user_pool_id = aws_cognito_user_pool.main.id
  generate_secret = false
}