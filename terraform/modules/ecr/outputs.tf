output "repository_url" {
  description = "The URL of the repository (e.g., aws_account_id.dkr.ecr.region.amazonaws.com/repo)"
  value       = aws_ecr_repository.main.repository_url
}

output "repository_arn" {
  description = "The ARN of the repository"
  value       = aws_ecr_repository.main.arn
}