pipeline{
    agent any
    tools{
        maven "maven3.8.4"
    }
    stages{
        stage('GitClone'){
            steps{
                sh "echo cloning the latest application version"
                git "https://github.com/aanuoluwapoakinyera/maven-web-application"
            }
        }
        stage('TestBuild'){
            steps{
                sh "echo Running unit test testing"
                sh "echo unitTesting ok. Creating packages"
                sh "mvn clean package"
                sh "echo Artifacts created"
            }
        }
        stage('codeQuality'){
            steps{
                sh "echo Running code quality report"
                sh "mvn sonar:sonar"
            }
        }
        stage('uploadArtifact'){
            steps{
                sh "echo upload artifacts into Nexus"
                sh "mvn deploy"
            }
        }
        stage('message'){
            steps{
                sh "echo CI job successful"
            }
        }
        stage('predeployment'){
            steps{
                sh "docker build -t aanuoluwapoakinyera/new-landmark-app . "
                //sh "docker login -u aanuoluwapoakinyera"
                sh "docker push aanuoluwapoakinyera/new-landmark-app"
            }
        }
    }
}



2. CD job - deploy to docker

pipeline{
    agent any
    stages{
        stage('UnDeploy'){
            steps{
                sh "echo Undeploying existing application"
                sh "docker rm -f mywebapp"
            }
        }
        stage('deployment'){
            steps{
                sh "echo application now ready for deployment"
                sh "docker run --name mywebapp -d -p 8000:8080 aanuoluwapoakinyera/new-landmark-app"
            }
        }
        stage('emailNotification'){
            steps{
                sh "echo deployment successful"
            }
        }
    }
}

Microservice
UI component on IIS
DB
AI/Machine Learning