 
pipeline {
    agent any

    stages {
        stage('BuildThesis') {
            steps {
                sh 'docker pull docker.io/2109199812/docker-latex'
                sh 'docker pull docker.io/texlive/texlive'
                sh 'docker run --rm -i -v ${PWD}:/diplom:Z 2109199812/docker-latex bash -c "make diplom"'
                sh 'docker run --rm -i -v ${PWD}:/root:Z texlive/texlive bash -c "cd /root && pdflatex -interaction=nonstopmode presentation && pdflatex -interaction=nonstopmode presentation"'
                sh 'make clean'
                sh 'mkdir -p Thesis'
                sh 'mv diplom.pdf ./Thesis/diplom.pdf'
                sh 'mv presentation.pdf ./Thesis/presentation.pdf'
            }
        }
    }
}
