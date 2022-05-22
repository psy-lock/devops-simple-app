pipeline {
    agent any
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
