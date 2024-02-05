
variable "google_credentials" {}
variable "google_project" {}
variable "google_default_region" { default = "us-central1" }
variable "google_default_zone" { default = "us-central1-a" }

variable "nomad_image_family" { default = "" }
variable "nomad_image_project" {}