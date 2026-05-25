module "vpc" {
  source = "../../modules/vpc"

  name_prefix = var.name_prefix
  vpc_cidr    = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  common_tags = var.common_tags
}

module "security" {
  source = "../../modules/security"

  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id

  common_tags = var.common_tags
}

module "iam" {
  source = "../../modules/iam"

  name_prefix = var.name_prefix

  common_tags = var.common_tags
}

module "eks" {
  source = "../../modules/eks"

  name_prefix         = var.name_prefix
  eks_cluster_version = var.eks_cluster_version

  private_subnet_ids = module.vpc.private_subnet_ids

  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn

  eks_cluster_security_group_id = module.security.eks_cluster_security_group_id

  node_instance_types = var.node_instance_types
  capacity_type       = var.capacity_type

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  common_tags = var.common_tags

  eks_cluster_policy_dependency = [
    module.iam
  ]

  eks_node_policy_dependency = [
    module.iam
  ]
}