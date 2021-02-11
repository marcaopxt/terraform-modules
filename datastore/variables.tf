variable "postgresql_release_config" {
  type    = map
  default = {
    postgres_username       = "postgres"
    postgres_password       = "password"      
  }
}
variable "pgadmin_release_config" {
  type    = map
  default = {
    postgres_host = "postgresql.postgresql.svc.cluster.local"      
  }
}
