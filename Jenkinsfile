pipeline {
    agent any
    tools {
        jdk 'java-11'
        maven 'maven-3.8.5'
    }
    environment {
        DOCKERHUB_USR='psylock'
        TOMCAT_CREDS=credentials('tomcat-deployer')
        IMAGE_NAME='devops-simple-app'
    }
    stages {
        stage('Build war') {
            steps {
                echo 'Running build automation'
                sh 'mvn clean package'
                archiveArtifacts artifacts: '**/*.war'
            }
        }
        post {
            always {
                junit '**/target/surefire-reports/TEST-*.xml'
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
         stage ('DeployToProduction') {
            steps {
                input 'Deploy to Production'
                withCredentials ([usernamePassword(credentialsId: 'jenkins-deployer', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "ssh -o StrictHostKeyChecking=no $USERNAME@${TOMCAT_URL} \"docker pull ${DOCKERHUB_USR}/${IMAGE_NAME}:${BUILD_NUMBER}\""
                        try {
                        sh "ssh -o StrictHostKeyChecking=no $USERNAME@${TOMCAT_URL} \"docker stop ${IMAGE_NAME}\""
                        sh "ssh -o StrictHostKeyChecking=no $USERNAME@${TOMCAT_URL} \"docker rm ${IMAGE_NAME}\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "ssh -o StrictHostKeyChecking=no $USERNAME@${TOMCAT_URL} \"docker run --restart always --name ${IMAGE_NAME} -p 9090:8080 -d ${DOCKERHUB_USR}/${IMAGE_NAME}:${BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
        
}
