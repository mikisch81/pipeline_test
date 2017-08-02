#!/usr/bin/env groovy

node('master') {
    ansiColor('xterm') {
        checkout scm

        withEnv(["MOSHE=123"]) {
            echo "\u001B[35mRunning job ${env.JOB_NAME}/${env.BUILD_ID} on ${env.JENKINS_URL}/${env.NODE_NAME} by ${params.TEST_USER}\u001B[0m"
            echo "${params.Greeting} World!"
            echo 'Global environment:'
            sh 'printenv MOSHE'

            stage('Build') {
                node('esfs-builder') {
                    echo "\u001B[31m${NODE_NAME}\u001B[0m build stage environment:"
                    sh 'printenv MOSHE'
                    sh 'make'
                    archiveArtifacts artifacts: '**/mikiApp', fingerprint: true
                    stash includes: '**/mikiApp', name: 'app'
                }
            }

            stage('Test') {
                parallel (
                    'Test1': {
                        node('pal-builder') {
                            withEnv(["MOSHE=456"]) {
                                echo "\u001B[32m${NODE_NAME}\u001B[0m test stage environment:"
                                sh 'printenv MOSHE'
                                unstash 'app'
                                sh './build/mikiApp'
                            }
                        }
                    },
                    'Test2': {
                        node('tz-tester-msm8996') {
                            withEnv(["MOSHE=789"]) {
                                echo "\u001B[34m${NODE_NAME}\u001B[0m test stage environment:"
                                sh 'printenv MOSHE'
                                unstash 'app'
                                sh './build/mikiApp'
                            }
                        }
                    }
                )
            }
        }
    }
}
