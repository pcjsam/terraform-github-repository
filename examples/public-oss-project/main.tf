# Public Open Source Project Example
# This example shows how to configure a public open source repository
# with community features enabled.

module "repository" {
  source = "../.."

  name        = "awesome-oss-project"
  description = "An open source project with community features"

  # Public visibility for open source
  visibility = "public"

  # Enable community features
  has_issues      = true
  has_discussions = true
  has_projects    = true
  has_wiki        = true

  # Allow multiple merge strategies for contributors
  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
  allow_auto_merge   = false

  # Branch settings
  default_branch         = "main"
  delete_branch_on_merge = true

  # Branch protection - relaxed for open source
  require_conversation_resolution = true
  required_status_checks_strict   = false
  require_pull_request_reviews    = true
  required_approving_review_count = 1

  # Topics for discoverability
  topics = ["open-source", "community", "awesome-oss-project"]

  # Maintainers
  admin_collaborators = ["maintainer-1", "maintainer-2"]
  write_collaborators = ["contributor-1"]

  # CI/CD variables
  actions_variables = {
    NPM_REGISTRY = "https://registry.npmjs.org"
  }
}

output "repository_name" {
  value = module.repository.repository_name
}
