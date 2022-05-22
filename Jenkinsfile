pipeline {
    agent any
    tools {
        jdk: 'java-11'
        maven: 'maven-3.8.5'
    }
    environment {
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
                deploy adapters: [tomcat8(url: 'http://$TOMCAT_URL:8080/', 
                    credentialsId: 'deployer')], 
                    war: 'target/*.war',
                    contextPath: 'webapp'
            }
            
        }
    }
        
}
