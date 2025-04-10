pipeline {
    agent {
        label 'MacAgentLocal'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build --platform=linux/amd64  -t qa-registration .'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    docker run --rm \
                        -v ${WORKSPACE}/results:/app/results \
                        qa-registration
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
                    
                    // Process robot results with error handling
                    script {
                        try {
                            robot outputPath: 'results/output.xml'
                        } catch (Exception e) {
                            echo "Warning: Failed to process robot results: ${e.message}"
                            currentBuild.result = 'UNSTABLE'
                        }
                    }
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