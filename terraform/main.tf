terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 3.0"
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

resource "vercel_project" "my_project" {
  name      = "iac-vercel-project"
  framework = null  # No framework for static site
}

output "production_url" {
  value       = format("https://%s.vercel.app", vercel_project.my_project.name)
  description = "The production URL for the project"
}