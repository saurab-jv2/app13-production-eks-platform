output "github_actions_role_arn" {
  value = module.github_oidc.github_actions_role_arn
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "aws_region" {
  value = var.aws_region
}

output "repository_name" {
  value = var.ecr_repo_name
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}