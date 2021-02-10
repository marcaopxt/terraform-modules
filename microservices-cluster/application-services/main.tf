resource "kubernetes_namespace" "transactions" {
  metadata {
    annotations = {}
    labels = {}
    name = "transactions"
  }
}
