pipeline {
    agent any

    tools {
        jdk 'Java-11' // Use the name of the configured JDK in Jenkins
    }

    environment {
        // K8s
        REGION = 'us-east-1'
        CLUSTER_NAME = 'kareem-cluster'
    }

    stages {
        stage('LINK TO K8s') {
            steps {
                echo "#### This is build stage number ${BUILD_NUMBER} ### "
                sh """
                aws eks --region ${REGION} update-kubeconfig --name ${CLUSTER_NAME}
                """
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
