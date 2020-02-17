provider "google-beta" {
  project = var.project_id
}

resource "google_project_service" "secretmanager" {
  provider = google-beta
  service  = "secretmanager.googleapis.com"

  disable_on_destroy = false
}

resource "google_secret_manager_secret" "my-secret" {
  provider = google-beta

  secret_id = "my-secret"

  replication {
    automatic = true
  }

  depends_on = [google_project_service.secretmanager]
}

resource "google_secret_manager_secret_version" "my-secret-1" {
  provider = google-beta

  secret      = google_secret_manager_secret.my-secret.id
  secret_data = "my super secret data"
}

resource "google_secret_manager_secret_iam_member" "my-app" {
  provider = google-beta

  secret_id = google_secret_manager_secret.my-secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "user:foo@bar.com"
}
