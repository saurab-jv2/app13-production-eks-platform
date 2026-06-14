resource "aws_eks_cluster" "main" {
  name     = "${var.name_prefix}-eks-cluster"
  role_arn = var.eks_cluster_role_arn

  version = var.eks_cluster_version

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    # Worker nodes are deployed in public subnets in the development environment
    # to eliminate NAT Gateway costs.
    # Disable Public subnet for optimum security
    # subnet_ids = var.public_subnet_ids 
    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      var.eks_cluster_security_group_id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    var.eks_cluster_policy_dependency
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-eks-cluster"
    }
  )
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.name_prefix}-node-group"
  node_role_arn   = var.eks_node_role_arn

  # Disable Public subnet for optimum security
  # subnet_ids = var.public_subnet_ids 
  subnet_ids = var.private_subnet_ids

  instance_types = var.node_instance_types
  capacity_type  = var.capacity_type

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  depends_on = [
    aws_eks_cluster.main,
    var.eks_node_policy_dependency
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-node-group"
    }
  )
}