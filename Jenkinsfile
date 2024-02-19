pipeline {
    agent any
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        DOCKER_IMAGE = 'nsuryagounder/chatbot:latest'
        ECR_REPOSITORY = 'projectchatbot'
        AWS_REGION = 'ap-south-1'
        AWS_ACCOUNT_ID = '262765012565'
    }
    
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Git Checkout') {
            steps {
                script {
                    git branch: 'main',
                        credentialsId: 'suryagounder',
                        url: 'https://github.com/suryagounder/chatbot'
                }
            }
        }
        
        stage('Unit Test Maven') {
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }

        stage('Integration Test Maven') {
            steps {
                script {
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonar-scanner'
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=project"
                    }
                }
            }
        }

        stage("Quality Gate") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
                }
            }
        }

        stage('Build and Package') {
           steps {
              sh 'mvn clean package'
            }
        }

        stage('push to artifactory') {
           steps {
                nexusArtifactUploader artifacts: [[artifactId: 'chatbot', classifier: '', file: 'target/chatbot.war', type: 'war']], 
                credentialsId: 'nexus', 
                groupId: 'in.javahome', 
                nexusUrl: '172.31.36.6:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'project-1.0', 
                version: '1.0-SNAPSHOT'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Assuming you have a Dockerfile in the root of your project
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    // Run Trivy scan on the Docker image
                    def trivyOutput = sh(script: 'trivy image nsuryagounder/chatbot', returnStdout: true).trim()
                    echo "Trivy Scan Output:\n${trivyOutput}"
            
                    // Check Trivy exit code and fail the build if vulnerabilities are found
                    if (currentBuild.resultIsWorseThan("SUCCESS")) {
                       error("Vulnerabilities found by Trivy.")
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                    }
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Authenticate with ECR
                    withCredentials([string(credentialsId: 'Aws-credentials', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'Aws-credentials', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                    }

                    // Tag the Docker image for ECR
                    sh "docker tag ${DOCKER_IMAGE} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${BUILD_NUMBER}"

                    // Push the Docker image to ECR
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${BUILD_NUMBER}"
                }
            }
        }
    }  
}
