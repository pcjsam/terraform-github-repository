# Microservice Repository Example
# This example shows how to create multiple microservice repositories
# with consistent configuration using a for_each pattern.

locals {
  microservices = {
    "user-service" = {
      description = "User management microservice"
      variables = {
        SERVICE_PORT = "8001"
        DB_NAME      = "users"
      }
    }
    "order-service" = {
      description = "Order processing microservice"
      variables = {
        SERVICE_PORT = "8002"
        DB_NAME      = "orders"
      }
    }
    "notification-service" = {
      description = "Notification delivery microservice"
      variables = {
        SERVICE_PORT = "8003"
        QUEUE_NAME   = "notifications"
      }
    }
  }
}

module "microservice" {
  source   = "../.."
  for_each = local.microservices

  name        = each.key
  description = each.value.description

  # Standard microservice settings
  visibility = "private"

  has_issues      = true
  has_discussions = false
  has_projects    = false
  has_wiki        = false

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
  allow_auto_merge   = true

  delete_branch_on_merge = true

  # Strict branch protection for microservices
  require_conversation_resolution = true
  required_status_checks_strict   = true
  require_pull_request_reviews    = true
  required_approving_review_count = 1

  topics = ["microservice", "backend", each.key]

  # Platform team as admins, developers as writers
  admin_collaborators = ["platform-team"]
  write_collaborators = ["backend-team"]

  # Service-specific variables plus common ones
  actions_variables = merge(each.value.variables, {
    ENVIRONMENT     = "production"
    DOCKER_REGISTRY = "ghcr.io/my-org"
  })
}

output "repository_names" {
  value = { for k, v in module.microservice : k => v.repository_name }
}
