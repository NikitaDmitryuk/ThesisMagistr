 
pipeline {
    agent any

    stages {
        stage('BuildThesis') {
            steps {
                sh 'make release'
                sh 'mkdir -p Thesis'
                sh 'mv diplom.pdf ./Thesis/diplom.pdf'
                sh 'mv presentation.pdf ./Thesis/presentation.pdf'
            }
        }
    }
}
