 
pipeline {
    agent any

    stages {
        stage('BuildThesis') {
            steps {
                sh 'make diplom'
                sh 'make presentation'
            }
        }
    }
}
