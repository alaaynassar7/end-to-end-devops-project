output "nlb_arn" {
  value = aws_lb.main.arn
}

output "nlb_dns_name" {
  value = aws_lb.main.dns_name
}

output "http_tg_arn" {
  value = aws_lb_target_group.http.arn
}

output "https_tg_arn" {
  value = aws_lb_target_group.https.arn
}