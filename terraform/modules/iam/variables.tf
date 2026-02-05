variable "project_name" {
  description = "Project name prefix used for resource identification"
  type        = string
}

variable "tags" {
  description = "Standard resource tags for the project"
  type        = map(string)
}