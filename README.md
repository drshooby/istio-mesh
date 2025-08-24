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

5. Set up your cluster (I'm using k3d):

```bash
k3d cluster create istio-practice
k3d cluster list
NAME             SERVERS   AGENTS   LOADBALANCER
istio-practice   1/1       0/0      true

# if you have kubectl config problems check the following
kubectl config current-context # check context
kubectl config get-contexts # list contexts
kubectl config use-context k3d-istio-practice # switch contexts
kubectl cluster-info # verify
```

5. Configure local environment:

```bash
# you will need an account that can create service accounts
gcloud auth login <ACCOUNT>
scripts/local_k8s_image_setup

# save the output command for before step 7
```

> **NOTE**: If you get: `failed to create secret Post "http://localhost:8080/api/v1/namespaces/default/secrets?fieldManager=kubectl-create&fieldValidation=Strict": dial tcp [::1]:8080: connect: connection refused`, check that your cluster is set up properly

6. Update `values.yaml` for each service:

```bash
# This is for setting up a service
service:
  type: ClusterIP
  port: 8000  # container listens on 8000
```

```bash
livenessProbe:
  httpGet:
    path: /healthz
    port: 8000

readinessProbe:
  httpGet:
    path: /readyz
    port: 8000
```

7. Deploy or upgrade the Helm charts into your `app` namespace:

```bash
kubectl create namespace app
scripts/rollout_deployment
```

8. (Optional) Port-forward for local testing:

```bash
kubectl port-forward -n app pod/<pod-name> 8000:8000
# then access locally: curl http://localhost:8000/hello
```
