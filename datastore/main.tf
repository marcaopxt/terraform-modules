resource "kubernetes_namespace" "postgresql" {
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


