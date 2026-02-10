
variable "project_name" {
  description = "Project name to be used for naming resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (nonprod/prod)"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {}
}