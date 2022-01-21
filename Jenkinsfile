pipeline {

    agent any

    stages {
      stage ("Get files to one directory") {
        steps {
        sh "sudo rsync -av --exclude '.*' /home/ec2-user/workspace/MyJob/ /home/ec2-user/BuildDir"
        }
    }
      stage ("Build image with Dockerfile")
        steps {

        def customImage = docker.build("tv3ran/deploywithjenkins:${env.BUILD_ID}")
        customImage.push()
        
        }
    }
}
