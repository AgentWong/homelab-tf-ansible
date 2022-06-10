pipeline {
    parameters {
        string(name: 'REF', defaultValue: '\${ghprbActualCommit}', description: 'Commit to build')
    }
    agent {
        dockerfile {
            label 'docker'
            filename 'terragrunt.dockerfile'
            args "--cap-add=IPC_LOCK -v /nfs/terraform/state:/project/tfstate --env-file=vault.password"
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
