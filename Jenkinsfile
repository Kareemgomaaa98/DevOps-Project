pipeline {
    agent any
    
    environment {
        SONAR_TOKEN = credentials('6fdbbd920c91857d03c7f7c837f5318c119f7530')  // Add your SonarQube token credential ID here
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build and Analyze') {
            steps {
                script {
                    def scannerHome = tool 'SonarQube Scanner'

                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=DevOps-Project \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://localhost:9000 \
                            -Dsonar.login=${SONAR_TOKEN}"
                    }
                }
            }
        }
    }
}

// steps to follow : 
//'CODE ANALYSIS with SONARQUBE'
//'QUALITY GATE'
//'CONTAINER BUILD'
//'CONTAINER PUSH'