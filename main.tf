provider "google" {
  project     = var.google_project
  region      = var.google_default_region
  credentials = var.google_credentials
}

resource "google_compute_instance_group" "instance_group" {
  name        = "nomad-ig"
  description = "Nomad instance group"
  zone        = var.google_default_zone
  #   network     = google_compute_network.default.id
}