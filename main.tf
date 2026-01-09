resource "github_repository" "repository" {
  name        = var.repository_name
  description = var.repository_description

  visibility = "private"

  has_issues      = false
  has_discussions = false
  has_projects    = false
  has_wiki        = false

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  allow_auto_merge = false

  delete_branch_on_merge = true

  topics = [var.repository_name, "managed-by-terraform"]

  archived = var.repository_archived
}

resource "github_branch" "repository_main_branch" {
  repository = github_repository.repository.name
  branch     = "main"
}

resource "github_branch_default" "repository_default_branch" {
  repository = github_repository.repository.name
  branch     = github_branch.repository_main_branch.branch
}

resource "github_branch_protection" "repository_main_branch_protection" {
  repository_id = github_repository.repository.id
  pattern       = "main"

  require_conversation_resolution = true

  required_status_checks {
    strict = true
  }

  dynamic "required_pull_request_reviews" {
    for_each = var.require_pull_request_reviews ? [1] : []
    content {
      required_approving_review_count = 1
      pull_request_bypassers          = [for admin_collaborator in var.repository_admin_collaborators : "/${admin_collaborator}"]
    }
  }
}

resource "github_repository_collaborators" "repository_collaborators" {
  repository = github_repository.repository.name

  dynamic "user" {
    for_each = var.repository_admin_collaborators
    content {
      username   = user.value
      permission = "admin"
    }
  }

  dynamic "user" {
    for_each = var.repository_write_collaborators
    content {
      username   = user.value
      permission = "push"
    }
  }
}
