data "template_file" "keycloak_release_template" {
  template = file("${path.module}/templates/keycloak-values.tpl.yaml")
  vars     = var.keycloak_release_config
}
resource "kubernetes_namespace" "keycloak" {
  count         = var.keycloak_enabled == false ? 0 : 1
  metadata {
    annotations = {}
    labels = {}
    name = "keycloak"
  }
}
resource "helm_release" "keycloak" {
  count         = var.keycloak_enabled == false ? 0 : 1
  name          = "keycloak"
  namespace     = "keycloak" 
  chart         = "keycloak"
  repository    = "https://codecentric.github.io/helm-charts"
  version       = "9.9.5"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [ data.template_file.keycloak_release_template.rendered ]
}
