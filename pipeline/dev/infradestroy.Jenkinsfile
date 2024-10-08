pipeline {
    agent { label 'agent1' }

     parameters{
        choice(name: 'region', choices: ['eu-north-1', 'us-east-2'], description: 'region')
    }

    stages {
        stage("Install Terraform") {
            steps {
                sh '''
                apt-get update || true
                apt-get install -y wget gnupg2 || true

                if [ -f /usr/share/keyrings/hashicorp-archive-keyring.gpg ]; then
                    rm /usr/share/keyrings/hashicorp-archive-keyring.gpg
                fi

                wget -qO- https://apt.releases.hashicorp.com/gpg  | gpg --dearmor --batch -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
                apt-get update 
                apt-get install -y terraform
                terraform version
                '''
            }
        }

        stage("Terraform Workspace") {
            steps{
                sh '''
                terraform workspace select $region || terraform workspace new $region
                '''
            }
        }

        stage("Terraform Apply") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'AWS', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    sh ''' 
                    cd tf
                    terraform init
                    terraform destroy -auto-approve -var-file regions.$region.dev.tfvars
                    '''
                }
            
            }
        }
    }
}
