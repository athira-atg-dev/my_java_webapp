pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'athiraasok'
        DOCKER_IMAGE = "${DOCKER_HUB_USER}/myapp:latest"
    }

    stages {

        stage('Build WAR with Maven') {
            steps {
                sh '''
                cd java-web-app
                mvn clean package -DskipTests
                '''
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    docker login -u $USER -p $PASS
                    docker build -t $DOCKER_IMAGE .
                    docker push $DOCKER_IMAGE
                    docker logout
                    '''
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                sshagent(['ansible_ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@172.31.27.21 "ansible-playbook ~/k8s_deploy.yml"
                    '''
                }
            }
        }
    }
}

