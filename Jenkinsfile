pipeline {
    agent terraform

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
            }
            steps {
                echo 'Planing..'
            }
            steps {
                echo 'Collecting and Checking..'
            }
        }
        stage('Deploy') {
            when {
                branch 'master'
            }            
            steps {
                echo 'Preparing....'
            }
            steps {
                echo 'Deploying....'
            }
        }
    }
}