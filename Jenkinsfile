pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'develop', url: 'https://github.com/github-mbm/aws-iam-security.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                sh '''
                cd terraform
                terraform init -input=false
                terraform apply -auto-approve
                '''
            }
        }

        stage('Get EC2 IP') {
            steps {
                script {
                    env.APP_IP = sh(
                        script: 'cd terraform && terraform output -raw app_server_ip',
                        returnStdout: true
                    ).trim()
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sshagent(['app-server-key']) {
                    sh """
                    echo "Deploying to EC2: ${env.APP_IP}"

                    scp -o StrictHostKeyChecking=no app.py ec2-user@${env.APP_IP}:/home/ec2-user/

                    ssh -o StrictHostKeyChecking=no ec2-user@${env.APP_IP} '
                        pkill -f app.py || true
                        nohup python3 /home/ec2-user/app.py > app.log 2>&1 &
                    '
                    """
                }
            }
        }

    }

    post {
        success {
            echo "✅ Deployment Successful!"
            echo "🌐 Access your app at: http://${env.APP_IP}:5000"
        }
        failure {
            echo "❌ Pipeline Failed. Check logs."
        }
    }
}