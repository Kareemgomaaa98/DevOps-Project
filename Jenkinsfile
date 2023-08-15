pipeline {
    agent any

    tools {
        jdk 'Java-11'// Use the name of the configured JDK in Jenkins
    }

    environment {
        SONAR_SCANNER_TOOL = 'SonarQube' // Manage Jenkins > Global Tool Configuration > Scroll down to the SonarScanner configuration section and click on Add SonarScanner.
        SONAR_TOKEN = credentials('SonarQube-Token') // Add SonarQube token credential ID here
        PROJECT_KEY = 'DevOps-Project'
        SOURCE_DIR = '.'
        SONAR_HOST = 'http://localhost:9000'
    }

    stages {
        // stage('Checkout') {  // Checkout to the ci branch
        //     steps {
        //         checkout scm
        //     }
        // }

        stage('CODE ANALYSIS with SONARQUBE') {
            steps {
                script {
                    def scannerHome = tool "${SONAR_SCANNER_TOOL}"
                    def jdkHome = tool 'Java-11'

                    withSonarQubeEnv("${SONAR_SCANNER_TOOL}") {
                        sh "/opt/sonarscanner/sonar-scanner-*-linux/bin/sonar-scanner \
                            -Dsonar.projectKey=${PROJECT_KEY} \
                            -Dsonar.sources=${SOURCE_DIR} \
                            -Dsonar.host.url=${SONAR_HOST} \
                            -Dsonar.login=${SONAR_TOKEN}"
                    }
                }
            }
        }

        // stage('QUALITY GATE') {  // Waits for a quality gate evaluation to complete within a 1-minute timeout, and if the evaluation fails, the pipeline is aborted.
        //     steps {
        //         timeout(time: 1, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

        // stage('CONTAINER BUILD') {
        //     steps {
        //         // Your container build steps here
        //     }
        // }

        // stage('CONTAINER PUSH') {
        //     steps {
        //         // Your container push steps here
        //     }
        // }
    }

    post {
        failure {
            slackSend(channel: "jenkins", color: "#FF0000", message: "FAILED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        success {
            slackSend(channel: "jenkins", color: "#00FF00", message: "SUCCEEDED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        aborted {
            slackSend(channel: "jenkins", color: "#808080", message: "ABORTED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
    }
}
