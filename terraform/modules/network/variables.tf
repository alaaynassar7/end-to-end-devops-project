variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidrs" {
  description = "Public subnet CIDR list"
  type        = list(string)
}

variable "private_cidrs" {
  description = "Private subnet CIDR list"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones list"
  type        = list(string)
}

variable "tags" {
  description = "Standard project tags"
  type        = map(string)
}