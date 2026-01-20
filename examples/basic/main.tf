# Basic Example
# This example shows the minimal configuration required to create a repository.

module "repository" {
  source = "../.."

  name        = "my-basic-repository"
  description = "A basic repository created with Terraform"

  admin_collaborators = ["your-github-username"]
  write_collaborators = []
}
