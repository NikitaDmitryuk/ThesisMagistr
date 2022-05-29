pipeline {
    agent any

    stages {

        stage('Purge old build') {
            steps{
                sh 'rm -f ./Thesis/*'
            }
        }

        stage('Download container') {
            steps{
                sh 'docker pull docker.io/2109199812/docker-latex'
            }
        }

        stage('Build diploma'){
            steps{
                sh 'docker run --rm -i -v ${PWD}:/diplom:Z 2109199812/docker-latex bash -c "make diploma"'
            }
        }

        stage('Build presentation'){
            steps{
                sh 'docker run --rm -i -v ${PWD}:/diplom:Z 2109199812/docker-latex bash -c "make presentation"'
            }
        }

        stage('Archive thesis'){
            steps{
                sh 'mkdir -p Thesis'
                sh 'mv Dmitryuk_Nikita_FN4-41M_diploma.pdf ./Thesis/Dmitryuk_Nikita_FN4-41M_diploma.pdf'
                sh 'mv Dmitryuk_Nikita_FN4-41M_presentation.pdf ./Thesis/Dmitryuk_Nikita_FN4-41M_presentation.pdf'
                sh 'rm -f Thesis.zip'
                sh 'rm -f ./Thesis/Thesis.zip'
                script{ zip zipFile: 'Thesis.zip', archive: false, dir: 'Thesis' }
                archiveArtifacts artifacts: 'Thesis.zip', fingerprint: true
                sh 'mv Thesis.zip ./Thesis/Thesis.zip'
            }
        }
    }
}
