pipeline {
    parameters {
        string(name: 'REF', defaultValue: '\${ghprbActualCommit}', description: 'Commit to build')
    }
    agent none
    stages {
        stage('Test') {
            agent {
                dockerfile {
                    label 'docker'
                    filename 'terragrunt.dockerfile'
                    args "--cap-add=IPC_LOCK -v /nfs/terraform/state:/project/tfstate -e VAULT_ADDR=${VAULT_ADDR} -e VAULT_TOKEN=${VAULT_TOKEN}"
                }
            }
            steps {
                sh "pwd"
                sh "hostname"
                sh "ls -lah"
                dir('terraform/dev'){
                    sh "pwd"
                    sh "terragrunt run-all validate"
                    sh "terragrunt hclfmt"
                }
            }
        }
        
    }
}
