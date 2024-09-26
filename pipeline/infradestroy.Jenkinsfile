pipeline {
    agent any 

     parameters{
        choice(name: 'env', choices: ['prod','dev'], description: 'env')
        choice(name: 'region', choices: ['eu-north-1', 'us-east-2'], description: 'region')
    }

    stages {
        stage("Install Terraform") {
            steps {
                 script {
                    // Attempt to install Terraform
                    def result = sh(script: '''
                    apt-get update || true
                    apt-get install -y wget gnupg2 || true
                    
                    # Add HashiCorp GPG key
                    wget -qO- https://apt.releases.hashicorp.com/gpg | gpg --dearmor --batch -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                    
                    # Add HashiCorp repository
                    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
                    
                    # Update package lists again
                    apt-get update 
                    
                    # Install Terraform
                    apt-get install -y terraform
                    terraform version
                    ''', returnStatus: true)

                    if (result != 0) {
                        error("Terraform installation failed with status: ${result}")
                    }
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
                    terraform destroy -auto-approve -var-file regions.$region.$env.tfvars
                    '''
                }
            
            }
        }
    }
}
}
