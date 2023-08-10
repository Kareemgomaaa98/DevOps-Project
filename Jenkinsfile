pipeline {
    agent any

    tools {
        // Use the name of the configured JDK in Jenkins
        jdk 'Java16'
    }
    
    environment {
        SONAR_SCANNER_TOOL= 'SonarQube'
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
                withCredentials([string(credentialsId: 'SonarQube-Token', variable: 'SONAR_TOKEN')]) {
                    script {
                        def scannerHome = tool "${SONAR_SCANNER_TOOL}"
                        def jdkHome = tool 'Java16'

                        // Set JAVA_HOME to the JDK installation directory
                        env.JAVA_HOME = jdkHome

                        withSonarQubeEnv('SonarQube') {
                            sh """
                            ${scannerHome}/bin/sonar-scanner \
                                -Dsonar.projectKey=${PROJECT_KEY} \
                                -Dsonar.sources=${SOURCE_DIR} \
                                -Dsonar.host.url=${SONAR_HOST} \
                                -Dsonar.login=\$SONAR_TOKEN
                            """
                        }
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