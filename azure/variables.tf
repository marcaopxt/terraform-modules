variable "azure_enabled" {
   type         = bool
   default      = false
   description  = "Use GCP GCS as backend state"
}
variable "aks_enabled" {
   type         = bool
   default      = false
   description  = "Use GCP GCS as backend state"
}

variable "project_id" {
    type        = string 
    default     = ""
    description = "GCP Project ID"
}

variable "region" {
    type        = string
    default     = "us-east1"
    description = "State's bucket region"
}