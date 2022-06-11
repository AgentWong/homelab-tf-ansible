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
                    args "--cap-add=IPC_LOCK -v /nfs/terraform/state:/project/tfstate:rw -e VAULT_ADDR=${VAULT_ADDR} -e VAULT_TOKEN=${VAULT_TOKEN}"
                }
            }
            steps {
                dir('terraform/dev/vsphere/base'){
                    sh "terragrunt validate"
                    sh "terragrunt apply --terragrunt-non-interactive"
                    sh "terragrunt state list"
                    sh "terragrunt output"
                }
            }
        }
        
    }
}
