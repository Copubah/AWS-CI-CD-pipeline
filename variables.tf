variable "github_owner" {
  description = "GitHub repository owner or organization"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to use"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "GitHub OAuth token for repository access"
  type        = string
  sensitive   = true
}

