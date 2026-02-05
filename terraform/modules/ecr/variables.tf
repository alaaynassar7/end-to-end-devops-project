variable "project_name" {
  description = "Project name prefix for ECR repository naming"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}