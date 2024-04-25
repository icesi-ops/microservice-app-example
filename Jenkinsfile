// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: node
    image: node
    command:
    - sleep
    args:
    - infinity
 
'''
            defaultContainer 'node'
        }
    }
    
    stages {
        stage('Build') {
            steps ('Install dependencies for todos-api'){
                dir('./todos-api'){
                sh 'npm i'
            }
            }
        }
        stage('Run unit tests'){
            steps {
                dir('./todos-api'){
                sh 'npm run test'
            }
            }
        }
        stage('Generate artifact'){
            steps {
                dir('./todos-api'){
                sh 'ls -lha'
                sh 'pwd'
                sh 'mkdir artifacts'
                sh "tar -czvf artifacts/todos-api:${env.BUILD_ID}.tar.gz ."
            }
            }
        }
    }
}
