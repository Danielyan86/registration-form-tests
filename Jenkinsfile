pipeline {
    agent {
        label 'MacAgentLocal'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build --platform=linux/amd64 -t qa-registration .'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    # Create results directory if it doesn't exist
                    mkdir -p ${WORKSPACE}/results
                    
                    # Run tests in Docker
                    docker run --rm \
                        -v ${WORKSPACE}/results:/app/results \
                        qa-registration
                    
                    # Verify test results exist
                    if [ ! -f "${WORKSPACE}/results/output.xml" ]; then
                        echo "Error: output.xml not found!"
                        exit 1
                    fi
                '''
            }
            post {
                always {
                    // First archive the artifacts
                    archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
                    
                    // Then process the robot results
                    script {
                        if (fileExists('results/output.xml')) {
                            robot outputPath: 'results/output.xml'
                        } else {
                            echo "Warning: output.xml not found, skipping robot step"
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