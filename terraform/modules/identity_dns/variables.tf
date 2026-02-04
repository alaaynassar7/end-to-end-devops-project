variable "project_name" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "The root domain name (e.g., example.com)"
}

variable "nlb_dns_name" {
  type        = string
}

variable "nlb_zone_id" {
  type        = string
}