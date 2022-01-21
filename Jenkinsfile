pipeline {

    agent any

    stages {
      stage ("Get files from github to one directory") {
        steps {
            checkout scm
            sh "sudo rsync -av --exclude '.*' /home/ec2-user/workspace/MyJob/ /home/ec2-user/BuildDir/"
        }
    }
        stage ("Build image with Dockerfile") {
        steps {
            script {

        customImage = docker.build("tv3ran/deploywithjenkins:${env.BUILD_ID}")
            }
        }
        }
    }
}
