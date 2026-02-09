variable "project_name" {
  type = string
}

variable "integration_uri" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "node_sg_arn" { 
    type = string 
}