variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "force_delete" {
  description = "Force deletion of repository even if images exist"
  type        = bool
  default     = true
}