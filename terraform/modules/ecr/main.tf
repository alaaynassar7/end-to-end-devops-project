# ------------------------------------------------------------------------
# Elastic Container Registry (ECR)
# ------------------------------------------------------------------------
resource "aws_ecr_repository" "main" {
  name                 = "${var.project_name}-repo"
  image_tag_mutability = "MUTABLE" # Allows overwriting tags like 'latest'

  # Critical for development/testing: Allows terraform destroy to work 
  # even if the repository contains images.
  force_delete = var.force_delete

  # Enable automatic vulnerability scanning
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

# ------------------------------------------------------------------------
# ECR Lifecycle Policy (Cost Optimization)
# ------------------------------------------------------------------------
resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 1 day"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep only the last 10 tagged images"
        selection = {
          tagStatus   = "tagged"
          tagPrefixList = ["v", "release"]
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}