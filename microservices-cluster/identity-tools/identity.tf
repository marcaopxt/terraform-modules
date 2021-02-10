resource "kubernetes_namespace" "keycloak" {
  metadata {
    annotations = {}
    labels = {}
    name = "keycloak"
  }
}
resource "kubernetes_namespace" "authentication" {
  metadata {
    annotations = {}
    labels = {}
    name = "authentication"
  }
}
