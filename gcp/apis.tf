resource "google_project_service" "bigquerystorage" {
  service                    = "bigquerystorage.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "bigquery" {
  service                    = "bigquery.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "cloudbuild" {
  service                    = "cloudbuild.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "clouddebugger" {
  service                    = "clouddebugger.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "cloudtrace" {
  service                    = "cloudtrace.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "containerregistry" {
  service                    = "containerregistry.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "datastore" {
  service                    = "datastore.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "deploymentmanager" {
  service                    = "deploymentmanager.googleapis.com"
  disable_dependent_services = true
} 
resource "google_project_service" "firebaserules" {
  service                    = "firebaserules.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "firestore" {
  service                    = "firestore.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "iam" {
  service                    = "iam.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "iamcredentials" {
  service                    = "iamcredentials.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "logging" {
  service                    = "logging.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "maps-backend" {
  service                    = "maps-backend.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "monitoring" {
  service                    = "monitoring.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "oslogin" {
  service                    = "oslogin.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "pubsub" {
  service                    = "pubsub.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "replicapool" {
  service                    = "replicapool.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "replicapoolupdater" {
  service                    = "replicapoolupdater.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "servicemanagement" {
  service                    = "servicemanagement.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "serviceusage" {
  service                    = "serviceusage.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "sourcerepo" {
  service                    = "sourcerepo.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "sql-component" {
  service                    = "sql-component.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "stackdriver" {
  service                    = "stackdriver.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "storage-api" {
  service                    = "storage-api.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "storage-component" {
  service                    = "storage-component.googleapis.com"
  disable_dependent_services = true
}
