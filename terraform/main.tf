terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 3.0"  # Latest stable for better static deploy support
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

resource "vercel_project" "my_project" {
  name      = "iac-vercel-project"
  framework = "create-react-app"  # Supports static HTML without build errors
}

resource "vercel_deployment" "my_deployment" {
  project_id = vercel_project.my_project.id
  files = {
    "index.html" = file("${path.module}/../site/index.html")
  }
}

output "deployment_url" {
  value       = vercel_deployment.my_deployment.url
  description = "The full URL of the deployed website (may include branch-specific preview)"
}

output "production_url" {
  value       = format("https://%s.vercel.app", vercel_project.my_project.name)
  description = "The production URL for the project (visit this for the live site)"
}