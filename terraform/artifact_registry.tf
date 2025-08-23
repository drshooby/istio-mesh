# ideally use a separate repo for each service image, but this is a small project
resource "google_artifact_registry_repository" "istio-practice-apps" {
  project       = var.project_id
  location      = "us-west1"
  repository_id = "istio-apps-repo"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}

resource "google_service_account" "artifact_pusher" {
  project      = var.project_id
  account_id   = "istio-app-artifact-pusher"
  display_name = "Service Account for istio practice artifact pushes"
}

resource "google_project_iam_member" "artifact_registry_writer" {
  project    = var.project_id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.artifact_pusher.email}"
  depends_on = [google_service_account.artifact_pusher]
}
