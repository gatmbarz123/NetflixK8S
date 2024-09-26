pipeline{ 
    agent any 
    
    parameters{
        choice(name: 'env', choices: ['prod','dev'], description: 'env')
        choice(name: 'region', choices: ['eu-north-1', 'us-east-2'], description: 'region')

    }

    stages{
        stage("Terraform Workspace"){
            steps{
                sh '''
                terraform workspace select $region
                '''
            }
        }
        
        
        stage("Terraform Apply"){
            steps{
                 sh ''' 
                terraform init
                terraform apply -auto-approve -var-file tf/regions.${region}.${env}.tfvars
                '''
            }
        }
    }

}