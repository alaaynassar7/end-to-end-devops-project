variable "project_name" {
  type        = string
  description = "Project name for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment (e.g., prod, nonprod)"
}

variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
}

variable "api_endpoint" {
  type        = string
  description = "The HTTPS endpoint from API Gateway used for Cognito callbacks"
}

variable "callback_url" {
  description = "Fallback/Dynamic URL passed from root/pipeline"
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
}