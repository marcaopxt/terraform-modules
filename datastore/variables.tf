variable postgresql_enabled {
  type = bool
  default = false
}
variable "postgresql_release_config" {
  type    = map
  default = {
    postgres_username       = "postgres"
    postgres_password       = "password"      
  }
}

variable pgadmin_enabled {
  type = bool
  default = false
}
variable "pgadmin_release_config" {
  type    = map
  default = {
    postgres_host = "postgresql.postgresql.svc.cluster.local"      
  }
}

variable cassandra_enabled {
  type = bool
  default = false
}
variable "cassandra_release_config" {
  type    = map
  default = {
    cassandra_host = "cassandra.cassandra.svc.cluster.local"      

  }
}
variable mongodb_enabled {
  type = bool
  default = false
}
variable "mongodb_release_config" {
  type    = map
  default = {
    mongodb_host = "mongodb.mongodb.svc.cluster.local"      
    rootPassword = "password"
  }
}
