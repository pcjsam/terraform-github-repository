variable "repository_name" {
  type        = string
  description = "Repository name"
}

variable "repository_description" {
  type        = string
  description = "Repository description"
}

variable "repository_admin_collaborators" {
  type        = list(string)
  description = "List of collaborators with admin permissions"
}

variable "repository_write_collaborators" {
  type        = list(string)
  description = "List of collaborators with write permissions"
}

variable "require_pull_request_reviews" {
  type        = bool
  description = "Whether to require pull request reviews before merging"
  default     = false
}

variable "repository_archived" {
  type        = bool
  description = "Whether to archive the repository. Can't be unarchived after being archived with the API."
  default     = false
}
