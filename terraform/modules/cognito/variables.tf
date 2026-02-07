variable "project_name" {
  description = "Project name prefix for resource naming"
  type        = string
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}

variable "api_id" {
  description = "The ID of the HTTP API Gateway to attach the authorizer to"
  type        = string
}