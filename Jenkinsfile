pipeline {
    parameters {
        string(name: 'REF', defaultValue: '\${ghprbActualCommit}', description: 'Commit to build')
    }
    agent none
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Base vSphere Setup') {
            agent {
                dockerfile {
                    label 'docker'
                    args '--cap-add=IPC_LOCK \
                    -v /nfs/terraform/state:/project/tfstate:rw \
                    -v /nfs/ansible/inventory:/project/ansible/inventory \
                    -e VAULT_ADDR=${VAULT_ADDR} -e VAULT_TOKEN=${VAULT_TOKEN} \
                    '
                }
            }
            steps {
                dir('ansible/inventory'){
                    sh "cp /project/ansible/inventory/homelab.vmware.yml ."
                }
                dir('terraform/dev/vsphere/base'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                    sh "terragrunt state list"
                }
                dir('terraform/dev/vsphere/tag_category'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                    sh "terragrunt state list"
                }
                dir('terraform/dev/vsphere/tags'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                    sh "terragrunt state list"
                }
                dir('terraform/dev/ad'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                    sh "terragrunt state list"
                }
            }
        }
        
    }
    post {
        // Clean after build
        always {
            node('docker'){
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true)
            }
        }
    }
}
