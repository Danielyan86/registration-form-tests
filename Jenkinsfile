pipeline {
    agent {
        label 'MacAgentLocal'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t qa-registration:${BUILD_NUMBER} .'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    docker run --rm \
                        -v ${WORKSPACE}/results:/app/results \
                        qa-registration:${BUILD_NUMBER}
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
                    junit 'results/output.xml'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Tests completed successfully!'
        }
        failure {
            echo 'Tests failed! Check the test reports for details.'
        }
    }
} 