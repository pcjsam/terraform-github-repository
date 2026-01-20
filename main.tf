resource "github_repository" "repository" {
  name        = var.name
  description = var.description

  visibility = var.visibility

  has_issues      = var.has_issues
  has_discussions = var.has_discussions
  has_projects    = var.has_projects
  has_wiki        = var.has_wiki

  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = var.allow_rebase_merge

  allow_auto_merge = var.allow_auto_merge

  delete_branch_on_merge = var.delete_branch_on_merge

  topics = var.topics

  archived = var.archived
}

resource "github_branch" "repository_main_branch" {
  repository = github_repository.repository.name
  branch     = var.default_branch
}

resource "github_branch_default" "repository_default_branch" {
  repository = github_repository.repository.name
  branch     = github_branch.repository_main_branch.branch
}

resource "github_branch_protection" "repository_main_branch_protection" {
  repository_id = github_repository.repository.id
  pattern       = var.default_branch

  require_conversation_resolution = var.require_conversation_resolution

  required_status_checks {
    strict = var.required_status_checks_strict
  }

  dynamic "required_pull_request_reviews" {
    for_each = var.require_pull_request_reviews ? [1] : []
    content {
      required_approving_review_count = var.required_approving_review_count
      pull_request_bypassers          = [for admin_collaborator in var.admin_collaborators : "/${admin_collaborator}"]
    }
  }
}

resource "github_repository_collaborators" "repository_collaborators" {
  repository = github_repository.repository.name

  dynamic "user" {
    for_each = var.admin_collaborators
    content {
      username   = user.value
      permission = "admin"
    }
  }

  dynamic "user" {
    for_each = var.write_collaborators
    content {
      username   = user.value
      permission = "push"
    }
  }
}

resource "github_actions_variable" "variable" {
  for_each = var.actions_variables

  repository    = github_repository.repository.name
  variable_name = each.key
  value         = each.value
}
