module "vpc" {
  source = "../../modules/vpc"

  name_prefix = var.name_prefix
  vpc_cidr    = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  enable_nat_gateway = var.enable_nat_gateway

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

  # Worker nodes are deployed in public subnets in the development environment
  # to eliminate NAT Gateway costs.
  # change it in EKS for optimum security
  public_subnet_ids  = module.vpc.public_subnet_ids 

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

module "ecr" {
  source = "../../modules/ecr"

  name                 = var.ecr_repo_name
  image_tag_mutability = var.image_tag_mutability

  name_prefix = var.name_prefix

  common_tags = var.common_tags
}

module "github_oidc" {
  source = "../../modules/github-oidc"

  github_org  = "saurab-jv2"
  github_repo = "app13-production-eks-platform"

  role_name = "github-actions-app13"

  common_tags = var.common_tags
}