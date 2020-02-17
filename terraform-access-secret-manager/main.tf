provider "google-beta" {
  project = var.project_id
}

data "google_secret_manager_secret_version" "my-secret" {
  provider = google-beta

  secret  = "my-secret"
  version = "1"
}

output "secret" {
  value = data.google_secret_manager_secret_version.my-secret.secret_data
}
