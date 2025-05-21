variable "region" { default = "us-east-1" }
variable "github_repo" { default = "your-username/ci-cd-pipeline" }
variable "github_branch" { default = "main" }
variable "github_token" {
  description = "GitHub OAuth token"
  type        = string
  sensitive   = true
}
