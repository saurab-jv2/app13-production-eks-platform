variable "aws_region" {
  description = "AWS region for backend resources"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
}

variable "common_tags" {
  description = "Common tags for backend resources"
  type        = map(string)
  default = {
    Project   = "app13"
    ManagedBy = "Terraform"
    Purpose   = "terraform-backend"
  }
}
