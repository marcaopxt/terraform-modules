/*{
    type = object({
        serviceType             = string
        prometheusEnabled       = string
        mavenAgentTag           = string
        helmAgentTag            = string
        terraformAgentTag       = string
        dockerAgentTag          = string
        dindAgentTag            = string
        chart_admin_username    = string
        chart_admin_password    = string
        computer_jnlpmac        = string
        computer_name           = string
        agent_idle_minutes      = string
        jobsConfiguration       = string
    })

    default = {
            serviceType             = "NodePort"
            prometheusEnabled       = "false"
            mavenAgentTag           = "latest"
            helmAgentTag            = "latest"
            terraformAgentTag       = "latest"
            dockerAgentTag          = "latest"
            dindAgentTag            = "latest"
            chart_admin_username    = "admin"
            chart_admin_password    = "password"
            computer_jnlpmac        = "agent"
            computer_name           = "agent"
            agent_idle_minutes      = "0"
            jobsConfiguration       = ""
    }

}
*/
variable "jenkins_release_config" {
  type    = object({
                serviceType             = string
                prometheusEnabled       = string
                mavenAgentTag           = string
                helmAgentTag            = string
                terraformAgentTag       = string
                dockerAgentTag          = string
                dindAgentTag            = string
                chart_admin_username    = string
                chart_admin_password    = string
                computer_jnlpmac        = string
                computer_name           = string
                agent_idle_minutes      = string
  })
  default = {
            serviceType             = "LoadBalancer"
            prometheusEnabled       = "false"
            mavenAgentTag           = "0.0.1"
            helmAgentTag            = "0.0.1"
            terraformAgentTag       = "0.0.1"
            dockerAgentTag          = "0.0.5"
            dindAgentTag            = "jdk11"
            chart_admin_username    = "admin"
            chart_admin_password    = "password"
            computer_jnlpmac        = "jenkins-agent"
            computer_name           = "jenkins-agent"
            agent_idle_minutes      = "15"
  }
}
variable "sonarqube_release_config" {
  type    = map
  default = {}
}
/*
list(object({
            name = string
            type = string
            job = map(object({
                repository = string
                pipelineLocation = string
            }))
        })
*/        