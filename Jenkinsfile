pipeline {

    agent any

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
       myImage.push("${env.BUILD_NUMBER}")            
       myImage.push("latest")
                }
              }    
            }
        }
    }
}
