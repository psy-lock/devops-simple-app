pipeline {
    agent any
    tools {
        jdk 'java-11'
        maven 'maven-3.8.5'
    }
    environment {
        DOCKERHUB_USR='psylock'
        IMAGE_NAME='devops-simple-app'
        SSH_COMMAND = "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/id_rsa jenkins@${TOMCAT_URL}"
    }
    stages {
        stage('Build war') {
            steps {
                echo 'Running build automation'
                sh 'mvn clean package'
            }
        }
    
         stage('Build Docker Image') {
            steps {
                echo 'Creating image'
                script {
                    app = docker.build("${DOCKERHUB_USR}/${IMAGE_NAME}")
                    app.inside {
                        sh 'echo "inside image"'
                    }
                }
            }
        }
       stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-token') {
                        app.push("$BUILD_NUMBER")
                        app.push("latest")
                    }
                }
            }
        }

         stage('Clean UP Docker Images') {
            steps {
                script{
                    try {
                        sh "docker rmi \$(docker images -q ${DOCKERHUB_USR}/*)"  
                    }
                    catch (err) {
                        echo: 'caught error: $err'
                    }
                }
            }
        }
         stage ('DeployToProduction') {
            steps {
                    script {
                        try {
                        sh "${SSH_COMMAND} \"docker stop ${IMAGE_NAME}\""
                        sh "${SSH_COMMAND} \"docker rm ${IMAGE_NAME}\""
                        sh "${SSH_COMMAND} \"docker rmi $(docker images -q ${DOCKERHUB_USR}/*)\"" 
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "${SSH_COMMAND} \"docker pull ${DOCKERHUB_USR}/${IMAGE_NAME}:${BUILD_NUMBER}\""
                        sh "${SSH_COMMAND} \"docker run --restart always --name ${IMAGE_NAME} \
                            -p 9090:8080 -d ${DOCKERHUB_USR}/${IMAGE_NAME}:${BUILD_NUMBER}\""
                }
            }
        }
    }
    post {
        always {
            junit '**/target/surefire-reports/TEST-*.xml'
            archiveArtifacts artifacts: '**/*.war'
        }
    }
}
