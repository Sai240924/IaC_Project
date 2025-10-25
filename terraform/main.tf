terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 3.0"  # Latest stable
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

resource "vercel_project" "my_project" {
  name      = "iac-vercel-project"
  framework = null  # Static HTML site
}

locals {
  # Compute file metadata for index.html
  index_html_path    = "${path.module}/../site/index.html"
  index_html_content = file(local.index_html_path)
  index_html_sha     = sha1(local.index_html_content)
  index_html_size    = length(local.index_html_content)
}

resource "vercel_deployment" "my_deployment" {
  project_id = vercel_project.my_project.id
  files = {
    "index.html" = "${local.index_html_size}~${local.index_html_sha}:${base64encode(local.index_html_content)}"
  }
  production = true  # Ensures production deployment
}

output "deployment_url" {
  value       = vercel_deployment.my_deployment.url
  description = "The full URL of the deployed website (may include branch-specific preview)"
}

output "production_url" {
  value       = format("https://%s.vercel.app", vercel_project.my_project.name)
  description = "The production URL for the project (visit this for the live site)"
}