data "google_client_config" "default" {}

data "terraform_remote_state" "devops" {
  backend = "gcs"
  config = {
    bucket  = "mapx-devtools-microservices-tf-state"
    prefix  = "modules/bigdata.tfstate"
  }
}

resource "kubernetes_namespace" "spark" {
    count         = var.spark_enabled == false ? 0 : 1  
    metadata {
        annotations = {}
        labels = {}
        name = "spark"
    }
}
data "template_file" "spark_release_template" {
    template = file("${path.module}/templates/spark-values.tpl.yaml")
    vars     = var.spark_release_config
}
resource "helm_release" "spark" {
    count         = var.spark_enabled == false ? 0 : 1  
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


resource "kubernetes_namespace" "kafka" {
    count         = var.kafka_enabled == false ? 0 : 1  
    metadata {
        annotations = {}
        labels = {}
        name = "kafka"
    }
}
data "template_file" "kafka_release_template" {
    template = file("${path.module}/templates/kafka-values.tpl.yaml")
    vars     = var.kafka_release_config
}
resource "helm_release" "kafka" {
    count         = var.kafka_enabled == false ? 0 : 1  
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
data "template_file" "kafdrop_release_template" {
    template = file("${path.module}/templates/kafdrop-values.tpl.yaml")
    vars     = var.kafdrop_release_config
}
resource "helm_release" "kafdrop" {
    count            = var.kafdrop_enabled == false ? 0 : 1  
    name             = "kafdrop"
    namespace        = "kafka"
    chart            = "kafdrop"
    repository       = "https://raw.githubusercontent.com/marcaopxt/helm-charts/master/pkg/kafdrop"
    version          = "3.1.8-rev4"                                                                                                              
    reuse_values     = false
    recreate_pods    = false
    force_update     = false
    create_namespace = true
    values        = [ data.template_file.kafdrop_release_template.rendered ]
}
