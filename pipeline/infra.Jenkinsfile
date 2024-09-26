pipeline {
    agent any 

    stages {
        stage("Install Terraform") {
            steps {
                sh '''
            
                sudo apt-get update && sudo apt-get install -y gnupg software-properties-common wget
                wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt-get update 
                # Install Terraform
                sudo apt-get install -y terraform
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
