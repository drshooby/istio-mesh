resource "google_service_account" "gke_account" {
  project      = var.project_id
  account_id   = "istio-app-gke-maker"
  display_name = "Service Account for creating gke clusters"
}

# Core GKE permissions
resource "google_project_iam_member" "gke_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

# IAM permissions for managing service accounts
resource "google_project_iam_member" "gke_iam_admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

resource "google_project_iam_member" "gke_iam_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

# Artifact Registry permissions
resource "google_project_iam_member" "gke_artifact_admin" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

# Compute permissions for GKE nodes
resource "google_project_iam_member" "gke_compute_admin" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

# Security permissions for firewall rules
resource "google_project_iam_member" "gke_security_admin" {
  project = var.project_id
  role    = "roles/compute.securityAdmin"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

# Storage permissions for GCR/Artifact Registry
resource "google_project_iam_member" "gke_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gke_account.email}"
}

resource "google_container_cluster" "primary" {
  name     = "istio-cluster"
  location = "us-west1-a" // gonna say we dont need multi location but if we did, it's just us-west1
  # project            = var.project_id
  initial_node_count = 1
  node_config {
    service_account = google_service_account.gke_account.email
    oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only"]
    machine_type    = "e2-medium"
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
  deletion_protection = false
}
