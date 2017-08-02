#!/usr/bin/env groovy

node('esfs-builder') {
    checkout scm

    stage('Build') {
        sh 'make'
        archiveArtifacts artifacts: '**/mikiApp', fingerprint: true
    }

    stage('Test') {
        sh './build/mikiApp'
    }
}
