pipeline {
  agent any
  stages {
    stage('build app') {
      steps {
        sh 'echo ":)"'
      }
    }

    stage('test app') {
      steps {
        sh 'echo ":)"'
      }
    }

    stage('create artifacts') {
      parallel {
        stage('create artifacts') {
          steps {
            sh 'echo ":)"'
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