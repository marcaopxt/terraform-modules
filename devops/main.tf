data "google_client_config" "default" {}

data "terraform_remote_state" "devops" {
  backend = "gcs"
  config = {
    bucket  = "mapx-devtools-microservices-tf-state"
    prefix  = "modules/devops.tfstate"
  }
}

resource "kubernetes_namespace" "jenkins" {
  metadata {
    annotations = {}
    labels = {}
    name = "jenkins"
  }
}

resource "kubernetes_persistent_volume" "jenkins_home" {
  metadata {
    name      = "jenkins-home"
    annotations = {
      "meta.helm.sh/release-name": "jenkins"
      "meta.helm.sh/release-namespace": "jenkins"
    }    
    labels = {
      "app.kubernetes.io/managed-by": "Helm"
    }
  }
  spec {
    capacity = {
      storage = "8Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      local {
        path = "/var/lib/docker/local-volumes/jenkins-home"
      }
    }    
    storage_class_name = "hostpath"
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "kubernetes.io/hostname"
            operator = "In"
            values = ["docker-desktop"]  # must mnanually put this one in
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins_home" {
  metadata {
    name      = "jenkins-home"
    namespace = "jenkins"
    annotations = {
      "meta.helm.sh/release-name": "jenkins"
      "meta.helm.sh/release-namespace": "jenkins"
    }
    labels = {
      "app.kubernetes.io/managed-by": "Helm"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "8Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.jenkins_home.metadata[0].name
    storage_class_name = "hostpath"
  }
}

data "template_file" "jenkins_release_template" {
  template = file("${path.module}/templates/jenkins-values.tpl.yaml")
  vars     = var.jenkins_release_config
}

resource "helm_release" "jenkins" {
    name          = "jenkins"
    namespace     = "jenkins" 
    chart         = "jenkins"
    repository    = "https://raw.githubusercontent.com/marcaopxt/helm-charts/master/pkg/mapx"
    version       = "3.1.8-rev4"
    reuse_values  = false
    recreate_pods = true
    force_update  = true
    values        = [ data.template_file.jenkins_release_template.rendered ]
  
}

data "template_file" "sonarqube_release_template" {
  template = file("${path.module}/templates/sonarqube-values.tpl.yaml")
  vars     = var.sonarqube_release_config
}

resource "helm_release" "sonarqube" {
    name             = "sonarqube"
    namespace        = "sonarqube"
    chart            = "sonarqube"
    repository       = "https://oteemo.github.io/charts"
    version          = "9.2.4"                                                                                                                         
    reuse_values     = false
    recreate_pods    = false
    force_update     = false
    create_namespace = true

    values        = [ data.template_file.sonarqube_release_template.rendered ]

}

