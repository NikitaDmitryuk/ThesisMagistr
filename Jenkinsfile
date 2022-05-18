 
pipeline {
    agent any

    stages {

        stage('Build diplom'){
            agent {
                docker {
                    image '2109199812/docker-latex'
                }
            }
            steps{
                sh 'make diplom'
                sh "cp diplom.pdf ${WORKSPACE}"
            }
        }

        stage('Build presentation'){
            agent {
                docker {
                    image '2109199812/docker-latex'
                }
            }
            steps{
                sh 'make presentation'
                sh "cp presentation.pdf ${WORKSPACE}"
            }
        }

        stage('Archive thesis'){
            steps{
                sh 'ls'
                sh 'mkdir -p Thesis'
                sh 'mv diplom.pdf ./Thesis/diplom.pdf'
                sh 'mv presentation.pdf ./Thesis/presentation.pdf'
                sh 'rm -f Thesis.zip'
                sh 'rm -f ./Thesis/Thesis.zip'
                script{ zip zipFile: 'Thesis.zip', archive: false, dir: 'Thesis' }
                archiveArtifacts artifacts: 'Thesis.zip', fingerprint: true
                sh 'mv Thesis.zip ./Thesis/Thesis.zip'
            }
        }
    }
}
