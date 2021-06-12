pipeline {
    agent {
        kubernetes {
        yaml """\
            apiVersion: v1
            kind: Pod
            metadata:
            labels:
                purpuse: terraform-builder
            spec:
            containers:
            - name: terraform
                image: hashicorp/terraform:0.14.11
                command:
                - cat
                tty: true
            """.stripIndent()
        }
    }    
    stages {
        stage('Check it out') {
            when {
                not {
                    anyOf {
                        branch 'master'
                        branch 'release'
                    }
                }
            } 
            steps {
                echo 'Linting..'
                echo 'Planing..'
                echo 'Collecting and Checking..'
            }
        }
        stage('Deploy') {
            when {
                branch 'master'
            }            
            steps {
                echo 'Preparing....'
                echo 'Deploying....'
            }
        }
    }
}
