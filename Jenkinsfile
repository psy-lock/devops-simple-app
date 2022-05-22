pipeline {
    agent any
    tools {
        jdk 'java-11'
        maven 'maven-3.8.5'
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh 'mvn clean package'
                archiveArtifacts artifacts: '**/*.war'
            }
        }
        stage('Deploy'){
            steps{
                deploy adapters: [tomcat8(url: "http://${TOMCAT_URL}:8080/", 
                    credentialsId: 'tomcat-deployer')], 
                    war: '**/*.war',
                    contextPath: 'simple-dynamic-page'
            }
            
        }
    }
    post {
        always {
            junit '**/target/surefire-reports/TEST-*.xml'
        }
    }
        
}
