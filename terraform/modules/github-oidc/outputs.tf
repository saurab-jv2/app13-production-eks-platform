output "github_actions_role_arn" {
  description = "GitHub Actions IAM role ARN"

  value = aws_iam_role.github_actions.arn
}

output "github_actions_role_name" {
  description = "GitHub Actions IAM role name"

  value = aws_iam_role.github_actions.name
}