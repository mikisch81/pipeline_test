#!/usr/bin/env groovy

node('master') {
    checkout scm

    withEnv(["MOSHE=123"]) {
        echo "Running job ${env.JOB_NAME}/${env.BUILD_ID} on ${env.JENKINS_URL}/${env.NODE_NAME} by ${params.TEST_USER}"
        echo "${params.Greeting} World!"
        echo 'Global environment:'
        sh 'printenv MOSHE'

        stage('Build') {
            node('esfs-builder') {
                echo "${NODE_NAME} build stage environment:"
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
                            echo "${NODE_NAME} test stage environment:"
                            sh 'printenv MOSHE'
                            unstash 'app'
                            sh './build/mikiApp'
                        }
                    }
                },
                'Test2': {
                    node('tz-tester-msm8996') {
                        withEnv(["MOSHE=789"]) {
                            echo "${NODE_NAME} test stage environment:"
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
