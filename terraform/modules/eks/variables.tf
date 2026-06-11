variable "name_prefix" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

# for dev environment only
variable "public_subnet_ids" {
  type = list(string)
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "eks_node_role_arn" {
  type = string
}

variable "eks_cluster_security_group_id" {
  type = string
}

variable "node_instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "common_tags" {
  type = map(string)
}

variable "eks_cluster_policy_dependency" {
  type = any
}

variable "eks_node_policy_dependency" {
  type = any
}