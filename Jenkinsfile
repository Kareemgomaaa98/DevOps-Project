pipeline {
    agent any

    tools {
        // Use the name of the configured JDK in Jenkins
        jdk 'Java-11'
    }
    
    environment {
        SONAR_SCANNER_TOOL= 'SonarQube' //Manage Jenkins > Global Tool Configuration > Scroll down to the SonarScanner configuration section and click on Add SonarScanner.
        SONAR_TOKEN = credentials('SonarQube-Token') // Add SonarQube token credential ID here
        PROJECT_KEY = 'DevOps-Project'
        SOURCE_DIR = '.'
        SONAR_HOST = 'http://localhost:9000'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm   //Checkout to the ci branch
            }
        }
        
        stage('Build and Analyze') {
            steps {
                script {
                    def scannerHome = tool "${SONAR_SCANNER_TOOL}"
                    def jdkHome = tool 'Java-11'  // Assuming you've configured the JDK in Jenkins

                    // Print out JDK and scanner paths
                    echo "JDK Path: ${jdkHome}"
                    echo "Scanner Path: ${scannerHome}"

                    // Set PATH to include JDK and scanner bin directories
                    env.PATH = "${jdkHome}/bin:${scannerHome}/bin:${env.PATH}"

                    // Print out PATH
                    echo "Updated PATH: ${env.PATH}"

                    withSonarQubeEnv('SonarQube') {
                        // Print debug information
                        sh 'echo $PATH'
                        sh 'which java'

                        // Change permission of java executable within SonarQube installation
                        sh "chmod 755 ${scannerHome}/jre/bin/java"

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
