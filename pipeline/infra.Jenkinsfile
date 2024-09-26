pipeline {
    agent any 

     parameters{
        choice(name: 'env', choices: ['prod','dev'], description: 'env')
        choice(name: 'region', choices: ['eu-north-1', 'us-east-2'], description: 'region')
    }

    stages {
        stage("Install Terraform") {
            steps {
                sh '''
            
                apt-get update && apt-get install -y gnupg software-properties-common wget
                wget -qO- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
                apt-get update 
                # Install Terraform
                apt-get install -y terraform
                terraform version
                '''
            }
        }

        stage("Terraform Workspace") {
            steps {
                sh '''
                terraform workspace select $region || terraform workspace new $region
                '''
            }
        }

        stage("Terraform Apply") {
            steps {
                sh ''' 
                terraform init
                terraform apply -auto-approve -var-file tf/regions.$region.$env.tfvars
                '''
            }
        }
    }
}
