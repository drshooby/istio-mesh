# istio-mesh

Service mesh practice project.

## This project uses GCP Artifact Registry

### Setup

1. Set up the GCP project:

```bash
scripts/gcloud_project_setup <PROJECT_ID>
```

2. Deploy infrastructure and permissions with Terraform:

```bash
terraform init
terraform plan
terraform apply
```

3. Create and authenticate service account for Artifact Registry:

```bash
scripts/artifact_service_setup <PROJECT_ID> <SERVICE_ACCOUNT_NAME> [REGION]
```

> **NOTE**: Default region here is us-west1

4. Push microservice images to Artifact Registry:

```bash
scripts/build_and_push <PROJECT_ID> <REPOSITORY_NAME> [REGION] [TAG]
```
