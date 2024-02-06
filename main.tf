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

data "google_compute_image" "nomad_image" {
  #   family  = var.nomad_image_family
  #   project = var.google_project
  name = var.nomad_image_project
}

resource "google_compute_instance_template" "server_instance_template" {
  name         = "nomad-server-instance-template"
  machine_type = "e2-micro"

  can_ip_forward = false

  tags = ["foo", "bar"]

  disk {
    source_image = data.google_compute_image.nomad_image.id
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "\n echo '\"runlist\":[\"nomad_cookbook\",\"nomad_cookbook[server]\"]' > /tmp/nomad.json \n chef-solo -j /tmp/nomad.json"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}