pipeline {
    agent any

    tools {
        jdk 'Java-11' // Use the name of the configured JDK in Jenkins
    }

    environment {
        // Sonarqube
        SONAR_SCANNER_TOOL = 'SonarQube' // Manage Jenkins > Global Tool Configuration > Scroll down to the SonarScanner configuration section and click on Add SonarScanner.
        SONAR_TOKEN = credentials('SonarQube-Token') // Add SonarQube token credential ID here
        PROJECT_KEY = 'DevOps-Project'
        SOURCE_DIR = '.'
        SONAR_HOST = 'http://localhost:9000'
        // Slack
        JOB_NAME = 'DevOps-Project'
        BUILD_ID = 'my_build_id'
        BUILD_URL = 'my_URL'
        SLACK_CHANNEL = '#cicd-project'
        // Nexus
        NEX_USERNAME = 'admin'
        NEX_PASSWORD = 'kareem@98'
        NEX_URL = 'http://localhost:8081/'
        NEX_REPO = 'localhost:6000/python-web-app-repo'
    }

    stages {
        // stage('CODE ANALYSIS with SONARQUBE') {
        //     steps {
        //         script {
        //             def scannerHome = tool "${SONAR_SCANNER_TOOL}"
        //             def jdkHome = tool 'Java-11'
        //             withSonarQubeEnv("${SONAR_SCANNER_TOOL}") {
        //                 sh "/opt/sonarscanner/sonar-scanner-*-linux/bin/sonar-scanner \
        //                     -Dsonar.projectKey=${PROJECT_KEY} \
        //                     -Dsonar.sources=${SOURCE_DIR} \
        //                     -Dsonar.host.url=${SONAR_HOST} \
        //                     -Dsonar.login=${SONAR_TOKEN}"
        //             }
        //         }
        //     }
        // }

        // stage('QUALITY GATE') {  // Waits for a quality gate evaluation to complete within a 1-minute timeout, and if the evaluation fails, the pipeline is aborted.
        //     steps {
        //         timeout(time: 1, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

        stage('CONTAINER BUILD') {
            steps {
                sh """
                docker login --username ${NEX_USERNAME} --password ${NEX_PASSWORD} ${NEX_REPO}
                docker build -t ${NEX_REPO}/my-website .
                """
            }
        }
        stage('PUSHHING THE IMAGE') {
            steps {
                sh """
                docker push ${NEX_REPO}/my-website
                """
            }
        }
    }

    post {
        failure {
            slackSend(channel: "${SLACK_CHANNEL}", color: "#FF0000", message: "FAILED 😢 : job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        success {
            slackSend(channel: "${SLACK_CHANNEL}", color: "#00FF00", message: "SUCCEEDED 🥳 : job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        aborted {
            slackSend(channel: "${SLACK_CHANNEL}", color: "#808080", message: "ABORTED 🤒 : job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
    }
}
