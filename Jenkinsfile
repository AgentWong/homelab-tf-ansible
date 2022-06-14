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
                    filename 'cytopia.dockerfile'
                    args '--cap-add=IPC_LOCK \
                    -v /nfs/terraform/state:/project/tfstate:rw \
                    -e VAULT_ADDR=${VAULT_ADDR} -e VAULT_TOKEN=${VAULT_TOKEN} \
                    '
                }
            }
            steps {
                dir('terraform/dev/vsphere/base'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                }
                dir('terraform/dev/vsphere/tag_category'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                }
                dir('terraform/dev/vsphere/tags'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                }
                dir('terraform/dev/vsphere/windows'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
                }
            }
        }
        stage('Deploy Active Directory') {
            agent {
                dockerfile {
                    label 'docker'
                    filename 'cytopia.dockerfile'
                    args '--cap-add=IPC_LOCK \
                    -v /nfs/terraform/state:/project/tfstate:rw \
                    -v /nfs/ansible/inventory:/project/ansible/inventory \
                    -v /nfs/ansible/krb5.conf:/etc/krb5.conf \
                    -e VAULT_ADDR=${VAULT_ADDR} -e VAULT_TOKEN=${VAULT_TOKEN} \
                    --dns 192.168.50.71 --dns 192.168.50.1 --dns-search eden.local \
                    '
                }
            }
            steps {
                dir('ansible/inventory'){
                    sh "cp /project/ansible/inventory/homelab.vmware.yml ."
                }
                dir('terraform/dev/ad'){
                    sh "terragrunt validate"
                    sh "terragrunt apply -auto-approve"
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
