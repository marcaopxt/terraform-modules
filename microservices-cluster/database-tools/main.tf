resource "kubernetes_namespace" "postgresql" {
  metadata {
    annotations = {}
    labels = {}
    name = "postgresql"
  }
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

  values        = [templatefile("templates/postgresql-values.tpl.yaml", {
    postgres_username       = "postgres"
    postgres_password       = "password"
  })]

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

  values        = [templatefile("templates/pgadmin-values.tpl.yaml", {
    postgres_host = "postgresql.postgresql.svc.cluster.local",
  })]
  
  depends_on     = [ helm_release.postgresql ]

}


