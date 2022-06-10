pipeline {
    parameters {
        string(name: 'REF', defaultValue: '\${ghprbActualCommit}', description: 'Commit to build')
    }
    agent {
        dockerfile {
            label 'docker'
            filename 'terragrunt.dockerfile'
            args "--cap-add=IPC_LOCK -v /nfs/terraform/state:/project/tfstate -e VAULT_ADDR=$VAULT_ADDR -e VAULT_TOKEN=$VAULT_TOKEN"
        }
    }
    stages {
        stage('Test') {
            steps {
                terragrunt hclfmt
            }
        }
        
    }
}
