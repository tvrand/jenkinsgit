pipeline {

    agent any

    stages {
      stage ("Get files from github to one directory") {
        steps {
            checkout scm
            sh "sudo rsync -av --exclude '.*' /home/ec2-user/workspace/MyJob/ /home/ec2-user/BuildDir"
            sh "cd /home/ec2-user/BuildDir/"
            
            
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
                    sh "cd /home/ec2-user/Templates/ && terraform init && terraform apply --auto-approve"
                         

        }
    }
            stage ("Configure env with Ansible") {
                steps {
                sh 'ssh-keygen -R 13.51.183.121 && ssh -o StrictHostKeyChecking=no -i /home/ec2-user/.ssh/ansible_key ec2-user@13.51.183.121 "cd /home/ec2-user/ForAnsible && ansible-playbook playbook.yaml"'
                }
            }
        }
}
