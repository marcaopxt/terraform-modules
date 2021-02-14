data "google_client_config" "default" {}

data "terraform_remote_state" "devops" {
  backend = "gcs"
  config = {
    bucket  = "mapx-devtools-microservices-tf-state"
    prefix  = "modules/bigdata.tfstate"
  }
}

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

data "template_file" "spark_release_template" {
  template = file("${path.module}/templates/spark-values.tpl.yaml")
  vars     = var.spark_release_config
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
    values        = [ data.template_file.spark_release_template.rendered ]
}

data "template_file" "kafka_release_template" {
  template = file("${path.module}/templates/kafka-values.tpl.yaml")
  vars     = var.kafka_release_config
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
    values        = [ data.template_file.kafka_release_template.rendered ]
}
