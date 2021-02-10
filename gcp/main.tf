data "google_client_config" "default" {
}

provider "google" {
  credentials = file("~/.config/gcloud/legacy_credentials/marcuspxt@gmail.com/adc.json")
  project     = "mapx-devtools"
  region      = "us-east1"
}

data "google_project" "project" {

}

output "project_number" {
  value = data.google_project.project.number
} 

