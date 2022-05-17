 
pipeline {
    agent any

    stages {

        stage('Download container') {
            steps{
                sh 'docker pull docker.io/2109199812/docker-latex'
            }
        }

        stage('Build diplom'){
            steps{
                sh 'docker run --rm -i -v ${PWD}:/diplom:Z 2109199812/docker-latex bash -c "make diplom"'
            }
        }

        stage('Build presentation'){
            steps{
                sh 'docker run --rm -i -v ${PWD}:/diplom:Z 2109199812/docker-latex bash -c "make presentation"'
            }
        }

        stage('Deploy thesis'){
            steps{
                sh 'mkdir -p Thesis'
                sh 'mv diplom.pdf ./Thesis/diplom.pdf'
                sh 'mv presentation.pdf ./Thesis/presentation.pdf'
                script{ zip zipFile: 'Thesis.zip', archive: false, dir: 'Thesis' }
                archiveArtifacts artifacts: 'Thesis.zip', fingerprint: true
            }
        }
    }
}
