pipeline{ 
    agent any 

    parameters{
        choice(name: 'env', choices: ['prod','dev'], description: 'env')
        choice(name: 'region', choices: ['eu-north-1', 'us-east-2'], description: 'region')

    }

    stages{
        stage("Terraforn install"){
            steps{
                sh '''
                apt-get update && apt-get install -y gnupg software-properties-common
                
                wget -O- https://apt.releases.hashicorp.com/gpg | \
                gpg --dearmor | \
                tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

                gpg --no-default-keyring \
                --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
                --fingerprint

                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
                https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
                tee /etc/apt/sources.list.d/hashicorp.list

                apt update

                apt-get install terraform

                terafform version
                '''
            }
        }



        stage("Terraform Workspace"){
            steps{
                sh '''
                terraform workspace select $region || terraform workspace new $region
                '''
            }
        }
        
        
        stage("Terraform Apply"){
            steps{
                 sh ''' 
                terraform init
                terraform apply -auto-approve -var-file tf/regions.$region.$env.tfvars
                '''
            }
        }
    }

}