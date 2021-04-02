

pipeline {
  environment {
    registry = "prathibha/docker-nodejs"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  
  agent any
  stages {
    stage('checkout scm') {
      steps {
	  
        git ''
		sh "git rev-parse --short HEAD > .git/commit-id"                        
        commit_id = readFile('.git/commit-id').trim()
      }
    }
	
	## Nodejs Test
   stage('test') {
      steps{
        script {
		nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'npm install --only=dev'
       sh 'npm test'
        }
      }
    }
	}
    ##Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$commit-id"
        }
      }
    }
	##Uploading Docker images into DockerHub
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$commit-id"
      }
    }
  }
}
