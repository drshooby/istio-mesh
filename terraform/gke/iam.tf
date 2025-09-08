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
