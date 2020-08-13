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
          environment {
            SSH = credentials('f51c83da-4f94-4cb8-b716-8d02b3e6eafa')
          }
          when { branch "master" }
          steps {
            sh 'echo "$SSH_KEY"'
          }
        }

      }
    }

  }
}
