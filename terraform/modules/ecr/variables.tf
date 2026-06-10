variable "name_prefix" {
  type = string
}

variable "name" {
  description = "ECR repository name"
  type        = string
}

variable "image_tag_mutability" {
  description = "IMMUTABLE or MUTABLE tags"
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  description = "Tags for ECR repo"
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  type = map(string)
}