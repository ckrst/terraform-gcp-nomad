packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "builder_sa" {
  type = string
}

source "googlecompute" "nomad" {
  project_id                  = var.project_id
  source_image_family         = "debian-cloud/debian-11"
  zone                        = var.zone
  image_description           = "Created with HashiCorp Packer from Cloudbuild"
  ssh_username                = "root"
  tags                        = ["packer"]
  impersonate_service_account = var.builder_sa
}

build {
  sources = ["sources.googlecompute.nomad"]
}