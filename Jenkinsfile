pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'develop', url: 'https://github.com/github-mbm/aws-iam-security.git'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'cd terraform && terraform init'
                sh 'cd terraform && terraform apply -auto-approve'
            }
        }

        stage('Get IP') {
            steps {
                script {
                    env.APP_IP = sh(
                        script: 'cd terraform && terraform output -raw app_server_ip',
                        returnStdout: true
                    ).trim()
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['app-server-key']) {
                    sh """
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
}
