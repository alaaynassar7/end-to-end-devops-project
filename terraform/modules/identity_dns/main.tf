# --- Route 53 Hosted Zone ---
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# --- Alias Record pointing to NLB ---
resource "aws_route53_record" "nlb_alias" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  #alias {
   # name                   = var.nlb_dns_name
   # zone_id                = var.nlb_zone_id
   # evaluate_target_health = true
  #}
}

# --- Cognito User Pool ---
resource "aws_cognito_user_pool" "pool" {
  name = "${var.project_name}-user-pool"

  password_policy {
    minimum_length = 8
  }
}

# --- Cognito Client ---
resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.project_name}-app-client"
  user_pool_id = aws_cognito_user_pool.pool.id
}