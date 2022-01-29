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
                    sshagent(credentials : ['ansiblekey']) {
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@13.40.100.44 "cd /home/ec2-user/ForAnsible/Kuber && ansible-playbook kubernodes.yml"'
                    }
                }
            }
        }
}
