pipeline {
    agent any
    
    parameters { 
        string(name: 'SERVICE_NAME', defaultValue: '', description: '')
        string(name: 'IMAGE_FULL_NAME_PARAM', defaultValue: '', description: '')
    }

    stages {
        stage('Git Setup') {
            steps {             
                sh 'git checkout -b main || git checkout main'
            }
        }  // <- This closing bracket was missing

        stage('Deploy') {
            steps {
                sh ''' 
                    cd k8s/${SERVICE_NAME}
                    sed -i "s|image: .*[image : $IMAGE_FULL_NAME_PARAM]|image: $IMAGE_FULL_NAME_PARAM|" deployed-prod.yaml
                    git add "deployed-prod.yaml"
                    git commit -m "NEW CHANGE: $IMAGE_FULL_NAME_PARAM"
                '''
            }
        }

        stage('Push to Github') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_TOKEN')]) {
                    sh 'git push https://$GITHUB_TOKEN@github.com/gatmbarz123/NetflixK8S.git'
                }
            }
        }
    }

    post {
        cleanup {
            cleanWs()
        }
    }
}
