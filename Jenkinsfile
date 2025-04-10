pipeline {
    agent {
        label 'MacAgentLocal'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -platform=linux/amd64  -t qa-registration .'
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
                    robot outputPath: 'results/output.xml'
                    
                    archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
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