pipeline {
    agent any

    environment {
        // K8s
        REGION = 'us-east-1'
        CLUSTER_NAME = 'kareem-cluster'
        // Slack
        JOB_NAME = 'DevOps-Project'
        BUILD_ID = 'my_build_id'
        BUILD_URL = 'my_URL'
        SLACK_CHANNEL = '#cicd-project'
    }

    stages {
        stage('LINK TO K8s') {
            steps {
                withCredentials([usernamePassword(credentialsId: "aws-key", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
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
    }
}
