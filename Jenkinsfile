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
            sh 'zip dir.zip -r .'
            archiveArtifacts 'dir.zip'
          }
        }

        stage('dockerize app') {
          steps {
            sh 'echo ":)"'
          }
        }

      }
    }

  }
}
