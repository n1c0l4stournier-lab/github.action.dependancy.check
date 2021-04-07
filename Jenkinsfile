pipeline {

    agent any


    triggers {

        pollSCM('*/1 * * * *')

    }
    
    stages {

        stage ('Docker Image') {

            steps {
                sh "mvn clean install -DskipTests"
            }

        }
    }
}
