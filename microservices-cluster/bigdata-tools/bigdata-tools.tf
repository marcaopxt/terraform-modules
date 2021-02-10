resource "kubernetes_namespace" "spark" {
  metadata {
    annotations = {}
    labels = {}
    name = "spark"
  }
}
resource "kubernetes_namespace" "kafka" {
  metadata {
    annotations = {}
    labels = {}
    name = "kafka"
  }
}
resource "helm_release" "spark" {
    name             = "spark"
    namespace        = "spark"
    chart            = "spark"
    repository       = "https://charts.bitnami.com/bitnami"
    version          = "5.1.1"                                                                                                                         
    reuse_values     = false
    recreate_pods    = false
    force_update     = false
    create_namespace = true
    values        = [templatefile("templates/spark-values.tpl.yaml", {
    })]
}
resource "helm_release" "kafka" {
    name             = "kafka"
    namespace        = "kafka"
    chart            = "kafka"
    repository       = "https://charts.bitnami.com/bitnami"
    version          = "12.7.4"                                                                                                                         
    reuse_values     = false
    recreate_pods    = false
    force_update     = false
    create_namespace = true
    values        = [templatefile("templates/kafka-values.tpl.yaml", {
    })]
}
