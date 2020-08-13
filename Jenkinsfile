pipeline {
  agent any
  environment{
      docker_username='joachimbulow'
  }
  stages {
    stage('clone down'){
      steps {
        stash excludes: '.git', name: 'code'
      }
    }

    stage('test app') {
      agent{
        docker{
          image 'python:3'
        }
      }
      steps {
        unstash 'code'
        sh 'pip install -r requirements.txt'
        sh 'python tests.py'
      }
    }

    stage('push docker app') {
      when { branch "master" }
      environment {
        DOCKERCREDS = credentials('docker_login') //use the credentials just created in this stage
                  }
      steps {
        sh './build-docker.sh'
        sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin' //login to docker hub with the credentials above
        sh './push-docker.sh'
        }
    }

    stage('artifacts and dockerize') {
      parallel {
        stage('create artifacts') {
          steps {
            unstash 'code'
            sh 'apt-get install zip'
            sh 'zip CoDeChan.zip -r .'
            archiveArtifacts 'CoDeChan.zip'
          }
        }

        stage('dockerize app') {
          when { branch "master" }
          steps {
            sshagent (credentials: ['f51c83da-4f94-4cb8-b716-8d02b3e6eafa']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@23.251.131.233 sh ./docker.sh'
            }

          }
        }

      }
    }

  }
}
