pipeline {
    agent any
    
    environment {
        SONAR_SCANNER_TOOL= 'sonar_scanner' //Manage Jenkins > Global Tool Configuration > Scroll down to the SonarScanner configuration section and click on Add SonarScanner.
        SONAR_TOKEN = '6fdbbd920c91857d03c7f7c837f5318c119f7530'  // Add your SonarQube token credential ID here
        PROJECT_KEY = 'DevOps-Project'
        SOURCE_DIR = '.'
        SONAR_HOST = 'http://localhost:9000'
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
                    def scannerHome = tool "${SONAR_SCANNER_TOOL}"

                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=${PROJECT_KEY} \
                            -Dsonar.sources=${SOURCE_DIR} \
                            -Dsonar.host.url=${SONAR_HOST} \
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