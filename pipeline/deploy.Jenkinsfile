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

        stage('Deploy') {
            steps {
                script{
                    dir("k8/${params.SERVICE_NAME}")
                        sh ''' 
                            sed -i "s|image: .*[image : $IMAGE_FULL_NAME_PARAM]" Netflix-frontend.yaml
                            git add "Netflix-frontend.yaml"
                            git commit -m "NEW CHANGE: $IMAGE_FULL_NAME_PARAM"
                        '''
                }
                
            }
        }
        stage ('Push to Github'){
            setup{
                withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_TOKEN')])
                sh 'git push https://$GITHUB_TOKEN@github.com/gatmbarz123/NetflixK8S.git'
            
            }
        }

    }
    post {
        cleanup {
            cleanWs()
        }
    }

}
}