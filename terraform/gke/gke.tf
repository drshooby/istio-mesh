resource "google_service_account" "gke_account" {
  project      = var.project_id
  account_id   = "istio-app-gke-maker"
  display_name = "Service Account for creating gke clusters"
}

resource "google_container_cluster" "primary" {
  name     = "istio-cluster"
  location = "us-west1-a" // gonna say we dont need multi location but if we did, it's just us-west1

  initial_node_count = 1

  node_config {
    service_account = google_service_account.gke_account.email
    machine_type    = "e2-medium"
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
  deletion_protection = false
}
