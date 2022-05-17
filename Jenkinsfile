 
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

        stage('Archive thesis'){
            steps{
                sh 'mkdir -p Thesis'
                sh 'mv diplom.pdf ./Thesis/diplom.pdf'
                sh 'mv presentation.pdf ./Thesis/presentation.pdf'
                sh 'rm Thesis.zip'
                script{ zip zipFile: 'Thesis.zip', archive: false, dir: 'Thesis' }
                archiveArtifacts artifacts: 'Thesis.zip', fingerprint: true
                sh 'mv Thesis.zip ./Thesis/Thesis.zip'
            }
        }

        stage('Send email'){
            steps{
                emailext attachmentsPattern: 'Thesis.zip',
                    body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                    subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
                    to: 'dmitryuk.nikita@gmail.com'
            }
        }
    }
}
