output "user_pool_id" { value = aws_cognito_user_pool.main.id }
output "client_id" { value = aws_cognito_user_pool_client.client.id }
output "client_secret" { value = aws_cognito_user_pool_client.client.client_secret }
output "cognito_issuer_url" { value = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.main.id}" }
output "domain" { value = aws_cognito_user_pool_domain.main.domain }