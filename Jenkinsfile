pipeline {
    agent any

    tools {
        // Use the name of the configured JDK in Jenkins
        jdk 'Java-11'
        // Configure the SonarQube scanner tool
        name 'SonarQube'
    }
    
    environment {
        SONAR_TOKEN = credentials('SonarQube-Token') // Add SonarQube token credential ID here
        PROJECT_KEY = 'DevOps-Project'
        SOURCE_DIR = '.'
        SONAR_HOST = 'http://localhost:9000'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scm   // Checkout to the ci branch
            }
        }
        
        stage('Code Analysis with SonarQube') {
            steps {
                script {
                    // Print JDK and SonarQube scanner paths
                    echo "JDK Path: ${tool 'Java-11'}"
                    echo "Scanner Path: ${tool 'SonarQube'}"

                    withSonarQubeEnv('SonarQube') {
                        // Print debug information
                        sh 'echo $PATH'
                        sh 'which java'

                        // Change permission of java executable within SonarQube installation
                        sh "chmod 755 ${tool('SonarQube')}/jre/bin/java"

                        // Run SonarQube analysis
                        sh "${tool('SonarQube')}/bin/sonar-scanner \
                            -Dsonar.projectKey=${PROJECT_KEY} \
                            -Dsonar.sources=${SOURCE_DIR} \
                            -Dsonar.host.url=${SONAR_HOST} \
                            -Dsonar.login=${SONAR_TOKEN}"
                    }
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                echo "Checking quality gate..."
                // Add your quality gate checks here
            }
        }
        
        stage('Container Build') {
            steps {
                echo "Building container..."
                // Add your container build steps here
            }
        }
        
        stage('Container Push') {
            steps {
                echo "Pushing container..."
                // Add your container push steps here
            }
        }
    }
}
