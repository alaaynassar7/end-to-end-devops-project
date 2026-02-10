variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., nonprod, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}