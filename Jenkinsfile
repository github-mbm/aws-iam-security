pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/github-mbm/aws-iam-security.git'
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
                    APP_IP = sh(
            script: 'cd terraform && terraform output -raw app_server_ip',
            returnStdout: true
          ).trim()
                }
            }
        }

        stages {
            stage('Deploy') {
                steps {
                    sshagent(['app-server-key']) {
                        sh '''
          scp -o StrictHostKeyChecking=no app.py ec2-user@${APP_IP}:/home/ec2-user/

          ssh -o StrictHostKeyChecking=no ec2-user@${APP_IP} '
            pkill -f app.py || true
            nohup python3 app.py > app.log 2>&1 &
          '
          '''
                    }
                }
            }
        }
    }
}
