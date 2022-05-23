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
                withCredentials ([usernamePassword(credentialsId: 'jenkins-deployer', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "ssh -o StrictHostKeyChecking=no -i /home/cloud_user/.ssh/id_rsa /$USERNAME@${TOMCAT_URL} \"systemctl status tomcat\""
                        
                    }
                }
            }
        }
    }
    post {
        always {
            junit '**/target/surefire-reports/TEST-*.xml'
        }
    }
}
