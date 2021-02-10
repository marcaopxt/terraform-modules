resource "kubernetes_namespace" "jenkins" {
  metadata {
    annotations = {}
    labels = {}
    name = "jenkins"
  }
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

    values        = [templatefile("templates/jenkins-values.tpl.yaml", {
        serviceType             = "LoadBalancer"
        prometheusEnabled       = "false"
        mavenAgentTag           = "0.0.1"
        helmAgentTag            = "0.0.1"
        terraformAgentTag       = "0.0.1"
        dockerAgentTag          = "0.0.2"
        chart_admin_username    = "admin"
        chart_admin_password    = "password"
        computer_jnlpmac        = "jenkins-agent"
        computer_name           = "jenkins-agent"
        agent_idle_minutes      = "15"
    #    persistent_volume_claim = kubernetes_persistent_volume_claim.jenkins
    })]
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
    values           = [templatefile("templates/sonarqube-values.tpl.yaml", {
    })]
}

