pipeline {

    agent any

    environment {
        AWS_ACCESS_KEY = 'AKIAXTTHHMJPHD6BB64V'
        AWS_SECRET_ACCESS_KEY = '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'
    }
    stages {
      stage ("Get files from github to one directory") {
        steps {
            sh "cd /home/ec2-user/BuildDir/"
            checkout scm
            
            
        }
    }
        stage ("Build image with Dockerfile") {
        steps {
            script {

        myImage = docker.build("tv3ran/deploywithjenkins:${env.BUILD_ID}")
            }
        }
        }
        stage ("Push docker image to repository") {
            steps {
                script {
                docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {                      
       myImage.push("latest")
                }
              }    
            }
        }
            stage ("Create environment with Terraform") {
                steps {
                    sh "cd /home/ec2-user/Templates/"
                    sh "terraform apply --auto-approve"
        }
    }
            stage ("Configure env with Ansible") {
                steps {
                sh 'ssh -i /home/ec2-user/.ssh/ansible_key ec2-user@13.51.183.121 "cd /home/ec2-user/ForAnsible && ansible-playbook playbook.yaml"'
                }
            }
        }
}
