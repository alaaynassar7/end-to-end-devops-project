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
  description = "If true, allows deleting the repository even if it contains images"
  type        = bool
  default     = true
}