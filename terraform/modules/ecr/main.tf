# --- Elastic Container Registry ---
# Repository to store and manage Docker container images
resource "aws_ecr_repository" "app_repo" {
  name                 = "${var.project_name}-app-repo"
  image_tag_mutability = "MUTABLE" # Allows overwriting tags for development agility

  # Enables vulnerability scanning on image push (Supports Plan Item 14)
  image_scanning_configuration {
    scan_on_push = true
  }

  # Configures encryption for images at rest
  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = var.tags
}

# --- ECR Lifecycle Policy ---
# Automatically cleans up old images to manage storage costs
resource "aws_ecr_lifecycle_policy" "cleanup_policy" {
  repository = aws_ecr_repository.app_repo.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep only the last 10 images"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 10
      }
      action = {
        type = "expire"
      }
    }]
  })
}