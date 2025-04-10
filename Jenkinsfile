pipeline {
    agent {
        label 'MacAgentLocal'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('qa-registration:${BUILD_NUMBER}')
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    docker.image('qa-registration:${BUILD_NUMBER}').inside {
                        sh 'robot -d results tests/robot_test_cases'
                    }
                }
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