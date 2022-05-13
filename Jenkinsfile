 
pipeline {
    agent any

    stages {
        stage('BuildThesis') {
            steps {
                sh 'docker pull docker.io/2109199812/docker-latex:latest'
                sh 'docker run --rm -i -v ${PWD}:/diplom:Z docker-latex bash -c "make diplom"'
                sh 'make presentation'
                sh 'make clean'
                sh 'mkdir -p Thesis'
                sh 'mv diplom.pdf ./Thesis/diplom.pdf'
                sh 'mv presentation.pdf ./Thesis/presentation.pdf'
            }
        }
    }
}
