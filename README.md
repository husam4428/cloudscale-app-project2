# Cloud Infrastructure Automation - Project 2

## 1. Authors & Student Information
* **Student Name 1:** Husam ahmed ali (Student ID: 4428)
* **Student Name 2:** Abdelmoez essam shalouf (Student ID: 4913)
* **Course:** Cloud Computing / Cloud Scale Labs
* **Date:** June 14, 2026

---

## 2. Project Title & Description
### Title: Automated Multi-Container Deployment via GitOps Architecture
This project demonstrates a production-grade GitOps delivery model. It automates the provisioning of an isolated Azure Container Instance (ACI) hosting a custom web application container using Terraform as Infrastructure as Code (IaC) and GitHub Actions as the CI/CD orchestrator.

---

## 3. Architecture Diagram
[ Developer Local Machine ]
│ (Git Push Code)
▼
[ GitHub Repository ] ──(Triggers)──► [ GitHub Actions Runner ]
│ (Validates & Executes IaC)
▼
[ Microsoft Azure Cloud ] ◄──────────────────┘ (Authenticates via OIDC/SP)
│
├──► [ Resource Group: husam-abdelmoez-proj2-aci-rg ]
│
└──► [ Azure Container Instance (ACI) ] ──► (Public IP / Port 80)







---

## 4. Docker Image Build and Push Instructions
To build and distribute the custom webserver application container, run the following sequential CLI commands:

```bash
# 1. Login to Docker Hub Registry
docker login -u husam4428

# 2. Build the Docker Image from local Dockerfile
docker build -t husam4428/cloudscale-app:v1 .

# 3. Push the finalized image layer to production registry
docker push husam4428/cloudscale-app:v1

```




5. Terraform Setup Instructions
The infrastructure layout configuration requires initializing and applying the state updates dynamically inside the cloud environment:

Ensure the parameters are mapped within main.tf with the appropriate production configurations.

Initialize the backend tracking provider configuration by running the terraform init command in your terminal.

Generate and audit the raw resource execution footprint plan by running the terraform plan command.

Asynchronously target and deploy the resources without manual input triggers by running the terraform apply -auto-approve -refresh=false -input=false command.

6. GitHub Actions Workflow Explanation
The automation pipeline engine configuration inside .github/workflows/terraform.yml works through discrete lifecycle segments:

Trigger Blocks: Active listening parameters detect any push or pull_request execution paths aiming at the production main branch.

Authentication Sub-layer: Uses azure/login@v2 utilizing encapsulated repository secrets (AZURE_CLIENT_ID, AZURE_TENANT_ID, etc.) to register a non-interactive programmatic console token.

Pipeline Flow: Sequentially builds the deployment ecosystem via Checkout Code to pull the current directory trees, Setup Terraform to compile the precise configuration binaries (v1.7.0), and Terraform Init/Plan/Apply to inject the system variables securely via dynamic runtime flags (TF_VAR_) to eliminate manual credential input prompts.

7. Embedded Execution Evidence Screenshots
Figure 1: App Registration SP Credentials Verification
Figure 2: Designated Project Resource Group Status
Figure 3: Azure Role Assignment Contributor Privileges
Figure 4: Cloud Shell Provider Resource Registration Success
Figure 5: GitHub Actions Pipeline Execution Success Run
8. Step-by-Step Detailed Solution
Application Packaging: The custom web application source was encapsulated inside a container utilizing a specialized base Linux configuration on Docker.

Access Security Layer: Configured a secure Service Principal account inside Azure Active Directory to provide explicit programmatic clearance.

IAM RBAC Mapping: Bound a strict scope role (Contributor) directly to the explicit pre-existing resource directory husam-abdelmoez-proj2-aci-rg to maintain strict multi-tenant boundaries.

Namespace Registration Resolution: Fixed an academic account service bottleneck by registering the Microsoft.ContainerInstance provider directly in the tenancy terminal ecosystem.

Continuous Deployment Delivery: Hooked the automated configuration parameters into the source environment code blocks, forcing the state management checks to finish natively with a pristine execution finish.

9. Project Repository Resource Link
Production Repository Address: https://github.com/husam4428/cloudscale-app-project2


....
--------------

