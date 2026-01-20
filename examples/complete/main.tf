# Complete Example
# This example demonstrates all available configuration options.

module "repository" {
  source = "../.."

  name        = "my-complete-repository"
  description = "A fully configured repository with all features enabled"

  # Visibility
  visibility = "private"

  # Repository features
  has_issues      = true
  has_discussions = true
  has_projects    = true
  has_wiki        = false

  # Merge settings
  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
  allow_auto_merge   = true

  # Branch settings
  default_branch         = "main"
  delete_branch_on_merge = true

  # Branch protection
  require_conversation_resolution = true
  required_status_checks_strict   = true
  require_pull_request_reviews    = true
  required_approving_review_count = 2

  # Topics
  topics = ["terraform", "example", "infrastructure"]

  # Collaborators
  admin_collaborators = ["lead-developer", "platform-team"]
  write_collaborators = ["developer-1", "developer-2", "developer-3"]

  # GitHub Actions variables
  actions_variables = {
    ENVIRONMENT   = "production"
    API_URL       = "https://api.example.com"
    REGION        = "us-east-1"
    ENABLE_CACHE  = "true"
  }
}

output "repository_name" {
  value = module.repository.repository_name
}
