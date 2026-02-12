variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "callback_url" {
  description = "Dynamic URL passed from root/pipeline"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}