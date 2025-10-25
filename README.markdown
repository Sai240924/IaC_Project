```markdown
# IaC Vercel Project

## Overview
This B.Tech project demonstrates **Infrastructure as Code (IaC)** using **Terraform** to manage a Vercel project and **Git** for version control, with deployment via the **Vercel CLI** to host a static website. The website is a simple HTML/CSS page (e.g., a portfolio) hosted at `https://iac-vercel-project.vercel.app`. The project follows version control best practices to ensure a clean, collaborative, and secure workflow, suitable for a DevOps pipeline.

Initially, I attempted to deploy the site entirely with Terraform, but due to persistent file parsing issues in the Vercel Terraform provider (v3.x), I used the Vercel CLI (`vercel --prod`) as a fallback to ensure a live output. Terraform manages the Vercel project settings, while the CLI handles file uploads for deployment.

## Live Demo
Visit my deployed website at: [https://iac-vercel-project.vercel.app](https://iac-vercel-project.vercel.app)

## Version Control Best Practices
I implemented the following best practices for IaC with Git:
1. **Git Tracking**: All code is versioned in a Git repository on GitHub.
2. **Organized Structure**: Files are organized in `site/` (HTML/CSS) and `terraform/` (IaC).
3. **Branching Strategy**: Used a `feature-add-css` branch for CSS updates, merged via pull requests.
4. **Clear Commit Messages**: Descriptive commits, e.g., "Added vercel.json to configure static site."
5. **No Secrets**: Vercel API token stored in environment variables, not in Git.
6. **Documentation**: This README and an ASCII workflow diagram explain the project.
7. **State Management**: Excluded `terraform.tfstate`, `.terraform.lock.hcl`, and other sensitive files in `.gitignore`.

## Project Workflow
Below is an ASCII diagram of the project workflow, showing how I write, version, and deploy the site:

```
IaC Vercel Workflow
==================
[Developer's Computer]
   |
   | 1. Write HTML/CSS & Terraform
   v
[Local Git Repository]
   | - Organized Folders, No Secrets
   | 2. Commit
   v
[Feature Branch]
   | - Branching, Clear Commits
   | 3. Push
   v
[GitHub Repository]
   | - Documentation
   | 4. Pull Request & Review
   v
[Main Branch]
   | 5. Pull
   v
[Developer's Computer]
   | 6. Terraform Apply (Project Settings)
   | 7. Vercel CLI Deploy (vercel --prod)
   v
[Vercel Website]
   | - View URL
   | 8. Verify
   v
[Done!]
```

## Architecture Diagram
The architecture diagram below visualizes the IaC workflow for deploying the static website, following standard diagramming conventions (rectangles, straight arrows, clear labels):

<image-card alt="Architecture Diagram" src="architecture.svg" ></image-card>

For GitHub rendering, here’s the Mermaid code:

```mermaid
graph TD
    A[Developer's Computer: Edit Files] -->|Commit Files| B[Local Git: Track Changes]
    B -->|Create feature-add-css| C[Feature Branch: CSS Updates]
    C -->|Push & Pull Request| D[GitHub: Review & Merge]
    D -->|Pull to Main| B
    B -->|Run terraform apply| E[Terraform: Manage Project]
    E -->|Set up iac-vercel-project| G[Vercel Platform: Host Site]
    B -->|Run vercel --prod| F[Vercel CLI: Deploy Files]
    F -->|Serve https://iac-vercel-project.vercel.app| G

    classDef component fill:#e6f3ff,stroke:#0070f3,stroke-width:2px,color:#000;
    classDef git fill:#e6ffe6,stroke:#28a745,stroke-width:2px,color:#000;
    classDef vercel fill:#ffe6e6,stroke:#ff3333,stroke-width:2px,color:#000;

    class A,E component;
    class B,C,D git;
    class F,G vercel;

## Setup Instructions
To replicate this project, you need **Git**, **Terraform**, **Node.js**, and **Vercel CLI** installed, plus a free Vercel account.

### Prerequisites
1. Install tools:
   - Git: [git-scm.com](https://git-scm.com)
   - Terraform: [terraform.io/downloads](https://www.terraform.io/downloads)
   - Node.js: [nodejs.org](https://nodejs.org) (LTS)
   - Vercel CLI: Run `npm install -g vercel`
2. Log in to Vercel:
   ```bash
   vercel login
   ```
3. Clone the repository (replace `yourusername` with your GitHub username):
   ```bash
   git clone https://github.com/yourusername/iac-vercel-project.git
   cd iac-vercel-project
   ```

### Terraform Setup
1. Set the Vercel API token (replace with your token from Vercel dashboard > Settings > Tokens):
   ```powershell
   # PowerShell
   $env:TF_VAR_vercel_api_token = "your-vercel-api-token"
   ```
2. Initialize and apply Terraform to create the project:
   ```powershell
   cd terraform
   terraform init
   terraform apply
   ```
   Type `yes` to create the Vercel project (`iac-vercel-project`).

### Deploy the Website
1. Deploy the site using Vercel CLI:
   ```powershell
   cd ../site
   vercel --prod
   ```
   Select the `iac-vercel-project` project when prompted. The output provides the live URL (e.g., `https://iac-vercel-project.vercel.app`).

### Make Changes
1. Create a feature branch:
   ```powershell
   git checkout -b feature-update
   ```
2. Edit files in `site/` (e.g., `index.html`, `style.css`).
3. Commit and push:
   ```powershell
   git add site/
   git commit -m "Updated site with new styles"
   git push origin feature-update
   ```
4. Create a pull request on GitHub, review, and merge to `main`.
5. Redeploy:
   ```powershell
   cd site
   vercel --prod
   ```

## Files
- `site/index.html`: Static website HTML.
- `site/style.css`: CSS styles (linked in `index.html`).
- `site/vercel.json`: Configures Vercel for static site deployment (disables build step).
- `terraform/main.tf`: Terraform code for Vercel project settings.
- `terraform/variables.tf`: Defines Vercel API token variable.
- `.gitignore`: Excludes `terraform.tfstate`, `.terraform.lock.hcl`, `.vercel`, `terraform.tfvars`.
- `README.md`: This documentation.

## Troubleshooting
- **Issue**: Terraform `vercel_deployment` failed with "Could not parse files" error.
  - **Fix**: Switched to Vercel CLI (`vercel --prod`) due to provider file parsing issues. Simplified Terraform to manage only project settings with `framework = null`.
- **Issue**: Vercel CLI failed with "react-scripts: command not found."
  - **Fix**: Added `site/vercel.json` to disable builds and set `framework = null` in Terraform for static site.
- **Issue**: CSS changes not visible.
  - **Fix**: Ensured `style.css` is linked in `index.html` and included in `site/`. Redeployed with `vercel --prod --force` to bypass cache.

## Project Learnings
This project taught me:
- How to use Terraform for IaC to manage Vercel project settings.
- Git best practices for version control (branching, clear commits, no secrets, documentation).
- Vercel CLI for reliable static site deployment.
- Debugging Terraform provider issues and using CLI as a workaround for production deployment.

For issues, check the Vercel dashboard (Projects > iac-vercel-project > Deployments) or run `vercel --debug`. Contact me via GitHub for help!