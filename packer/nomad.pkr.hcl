packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/googlecompute"
    }
    chef = {
      source  = "github.com/hashicorp/chef"
      version = ">=1.0.2"
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
  # source_image                  = "debian-8-jessie-v20161027"
  source_image_family         = "ubuntu-2204-lts"
  zone                        = var.zone
  
  image_name                  = "nomad"
  image_description           = "Created with HashiCorp Packer"
  scopes                      = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.full_control"
  ]

  service_account_email = var.builder_sa

  ssh_username                = "root"
  tags                        = ["packer"]
  # impersonate_service_account = var.builder_sa

  metadata = {
    "startup_script" = <<EOF
#! /bin/bash
apt-get update
apt-get install -y unzip
EOF
  }


}



build {
  sources = ["sources.googlecompute.nomad"]

  provisioner "chef-solo" {
    cookbook_paths = [ "packer/chef/berks-cookbooks ]
    run_list       = ["nomad"]
    skip_install   = false
  }
}

