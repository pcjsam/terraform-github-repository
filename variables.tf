variable "name" {
  type        = string
  description = "Repository name"
}

variable "description" {
  type        = string
  description = "Repository description"
}

variable "visibility" {
  type        = string
  description = "Repository visibility (public, private, or internal)"
  default     = "private"
}

variable "has_issues" {
  type        = bool
  description = "Whether to enable GitHub Issues for the repository"
  default     = false
}

variable "has_discussions" {
  type        = bool
  description = "Whether to enable GitHub Discussions for the repository"
  default     = false
}

variable "has_projects" {
  type        = bool
  description = "Whether to enable GitHub Projects for the repository"
  default     = false
}

variable "has_wiki" {
  type        = bool
  description = "Whether to enable GitHub Wiki for the repository"
  default     = false
}

variable "allow_merge_commit" {
  type        = bool
  description = "Whether to allow merge commits for pull requests"
  default     = false
}

variable "allow_squash_merge" {
  type        = bool
  description = "Whether to allow squash merges for pull requests"
  default     = true
}

variable "allow_rebase_merge" {
  type        = bool
  description = "Whether to allow rebase merges for pull requests"
  default     = false
}

variable "allow_auto_merge" {
  type        = bool
  description = "Whether to allow auto-merge for pull requests"
  default     = false
}

variable "delete_branch_on_merge" {
  type        = bool
  description = "Whether to delete head branches after merging pull requests"
  default     = true
}

variable "topics" {
  type        = list(string)
  description = "Topics to add to the repository"
  default     = []
}

variable "archived" {
  type        = bool
  description = "Whether to archive the repository. Can't be unarchived after being archived with the API."
  default     = false
}

variable "default_branch" {
  type        = string
  description = "The default branch name for the repository"
  default     = "main"
}

variable "require_conversation_resolution" {
  type        = bool
  description = "Whether to require conversation resolution before merging"
  default     = true
}

variable "required_status_checks_strict" {
  type        = bool
  description = "Whether to require branches to be up to date before merging"
  default     = true
}

variable "require_pull_request_reviews" {
  type        = bool
  description = "Whether to require pull request reviews before merging"
  default     = false
}

variable "required_approving_review_count" {
  type        = number
  description = "Number of required approving reviews before merging"
  default     = 1
}

variable "admin_collaborators" {
  type        = list(string)
  description = "List of collaborators with admin permissions"
}

variable "write_collaborators" {
  type        = list(string)
  description = "List of collaborators with write permissions"
}

variable "actions_variables" {
  type        = map(string)
  description = "Map of GitHub Actions variables to create (key = variable name, value = variable value)"
  default     = {}
}
