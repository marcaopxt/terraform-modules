resource "kubernetes_namespace" "postgresql" {
  count         = var.postgresql_enabled == false ? 0 : 1
  metadata {
    annotations = {}
    labels = {}
    name = "postgresql"
  }
}

data "template_file" "postgresql_release_template" {
  template = file("${path.module}/templates/postgresql-values.tpl.yaml")
  vars     = var.postgresql_release_config
}

resource "helm_release" "postgresql" {
  count         = var.postgresql_enabled == false ? 0 : 1
  name          = "postgresql"
  namespace     = "postgresql" 
  chart         = "postgresql"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = "10.2.6"
  reuse_values  = false
  recreate_pods = true
  force_update  = true
  values        = [ data.template_file.postgresql_release_template.rendered ]
}

data "template_file" "pgadmin_release_template" {
  template = file("${path.module}/templates/pgadmin-values.tpl.yaml")
  vars     = var.pgadmin_release_config
}

resource "helm_release" "pgadmin" {
  count         = var.pgadmin_enabled == false ? 0 : 1
  name          = "pgadmin"
  namespace     = "postgresql" 
  chart         = "pgadmin4"
  repository    = "https://helm.runix.net/"
  version       = "1.4.6"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [ data.template_file.pgadmin_release_template.rendered ]
  
  depends_on     = [ helm_release.postgresql ]

}

data "template_file" "cassandra_release_template" {
  template = file("${path.module}/templates/cassandra-values.tpl.yaml")
  vars     = var.cassandra_release_config
}

resource "kubernetes_namespace" "cassandra" {
  count         = var.mongodb_enabled == false ? 0 : 1  
  metadata {
    annotations = {}
    labels = {}
    name = "cassandra"
  }
}
resource "helm_release" "cassandra" {
  count         = var.cassandra_enabled == false ? 0 : 1
  name          = "cassandra"
  namespace     = "cassandra" 
  chart         = "cassandra"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = "7.3.2"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [ data.template_file.cassandra_release_template.rendered ]

}

data "template_file" "mongodb_release_template" {
  template = file("${path.module}/templates/mongodb-values.tpl.yaml")
  vars     = var.mongodb_release_config
}
resource "kubernetes_namespace" "mongodb" {
  count         = var.mongodb_enabled == false ? 0 : 1
  metadata {
    annotations = {}
    labels = {}
    name = "mongodb"
  }
}
resource "helm_release" "mongodb" {
  count         = var.mongodb_enabled == false ? 0 : 1
  name          = "mongodb"
  namespace     = "mongodb" 
  chart         = "mongodb"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = "10.7.0"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [ data.template_file.mongodb_release_template.rendered ]

}




