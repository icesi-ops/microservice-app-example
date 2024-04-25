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
            steps ('Install dependencies for todo-api'){
                dir('./todo-api'){
                sh 'npm i'
            }
            }
        }
        stage('Run unit tests'){
            steps {
                dir('./todo-api'){
                sh 'npm run test'
            }
            }
        }
        stage('Generate artifact'){
            steps {
                dir('./todo-api'){
                sh 'ls -lha'
                sh 'pwd'
                sh 'mkdir artifacts'
                sh "tar -czvf artifacts/todo-api:${env.BUILD_ID}.tar.gz ."
            }
            }
        }
    }
}
