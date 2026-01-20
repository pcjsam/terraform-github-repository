# Terraform GitHub Repository Module

A Terraform module for creating and managing GitHub repositories with opinionated defaults for branch protection, collaborators, and GitHub Actions variables.

## Features

- Creates a GitHub repository with configurable settings
- Sets up default branch with branch protection rules
- Manages repository collaborators with admin and write permissions
- Configures GitHub Actions variables
- Enforces squash merge by default with automatic branch deletion

## Usage

### Basic Example

```hcl
module "my_repository" {
  source = "path/to/terraform-github-repository"

  name        = "my-awesome-project"
  description = "An awesome project repository"

  admin_collaborators = ["admin-user"]
  write_collaborators = ["developer-user"]
}
```

### Complete Example

```hcl
module "my_repository" {
  source = "path/to/terraform-github-repository"

  name        = "my-awesome-project"
  description = "An awesome project repository"

  # Visibility
  visibility = "private"

  # Repository features
  has_issues      = true
  has_discussions = true
  has_projects    = false
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
  topics = ["terraform", "infrastructure", "my-awesome-project"]

  # Collaborators
  admin_collaborators = ["admin-user", "lead-developer"]
  write_collaborators = ["developer-1", "developer-2"]

  # GitHub Actions variables
  actions_variables = {
    ENVIRONMENT = "production"
    API_URL     = "https://api.example.com"
    REGION      = "us-east-1"
  }
}
```

## Examples

More detailed examples can be found in the [`examples/`](./examples/) directory:

| Example | Description |
|---------|-------------|
| [basic](./examples/basic/) | Minimal configuration with just required variables |
| [complete](./examples/complete/) | All available options configured |
| [public-oss-project](./examples/public-oss-project/) | Public open source repository with community features |
| [microservice](./examples/microservice/) | Advanced pattern using `for_each` to create multiple repositories |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| github | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| github | >= 5.0 |

## Resources

This module creates the following resources:

| Resource | Description |
|----------|-------------|
| `github_repository` | The GitHub repository |
| `github_branch` | The default branch |
| `github_branch_default` | Sets the default branch |
| `github_branch_protection` | Branch protection rules for the default branch |
| `github_repository_collaborators` | Repository collaborators |
| `github_actions_variable` | GitHub Actions variables (if any are defined) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Repository name | `string` | n/a | yes |
| `description` | Repository description | `string` | n/a | yes |
| `admin_collaborators` | List of collaborators with admin permissions | `list(string)` | n/a | yes |
| `write_collaborators` | List of collaborators with write permissions | `list(string)` | n/a | yes |
| `visibility` | Repository visibility (public, private, or internal) | `string` | `"private"` | no |
| `has_issues` | Whether to enable GitHub Issues for the repository | `bool` | `false` | no |
| `has_discussions` | Whether to enable GitHub Discussions for the repository | `bool` | `false` | no |
| `has_projects` | Whether to enable GitHub Projects for the repository | `bool` | `false` | no |
| `has_wiki` | Whether to enable GitHub Wiki for the repository | `bool` | `false` | no |
| `allow_merge_commit` | Whether to allow merge commits for pull requests | `bool` | `false` | no |
| `allow_squash_merge` | Whether to allow squash merges for pull requests | `bool` | `true` | no |
| `allow_rebase_merge` | Whether to allow rebase merges for pull requests | `bool` | `false` | no |
| `allow_auto_merge` | Whether to allow auto-merge for pull requests | `bool` | `false` | no |
| `delete_branch_on_merge` | Whether to delete head branches after merging pull requests | `bool` | `true` | no |
| `topics` | Topics to add to the repository | `list(string)` | `[]` | no |
| `archived` | Whether to archive the repository | `bool` | `false` | no |
| `default_branch` | The default branch name for the repository | `string` | `"main"` | no |
| `require_conversation_resolution` | Whether to require conversation resolution before merging | `bool` | `true` | no |
| `required_status_checks_strict` | Whether to require branches to be up to date before merging | `bool` | `true` | no |
| `require_pull_request_reviews` | Whether to require pull request reviews before merging | `bool` | `false` | no |
| `required_approving_review_count` | Number of required approving reviews before merging | `number` | `1` | no |
| `actions_variables` | Map of GitHub Actions variables to create (key = variable name, value = variable value) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `repository_name` | Repository name |

## Notes

- When `require_pull_request_reviews` is enabled, admin collaborators are automatically added as pull request bypassers
- The repository cannot be unarchived via the API once archived - use with caution
- Branch protection is automatically applied to the default branch
