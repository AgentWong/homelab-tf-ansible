# Terraform and Ansible with Jenkins
This project is for testing Terraform and Ansible in a Jenkins pipeline in my homelab.

## Environment
Hardware:
- 4x Intel NUCs running ESXi hypervisors and vSAN.
- 1x QNAP NAS for NFS

Virtual:
- 1x vCenter
- 1x Ubuntu Server 22.04 running Jenkins Controller in Docker
- 1x Ubuntu Server 22.04 running as a Jenkins agent

## Workflow
Jobs are executed on the Jenkins Agent from a Docker container that is created using an Alpine Linux dockerfile.  This image contains the tools that are needed such as Terraform, Terragrunt, and Ansible as well as all dependent packages such as pywinrm to communicate with Windows domain-joined VMs, or pyvmomi to use the VMWare Ansible dynamic inventory script.

Based on testing and research, it seems most efficient to call Ansible within Terraform itself as part of the local-exec provisioner for a resource.  This is because it allows Terraform to keep track of the success/failure of the Ansible playbook executions (provided you have some means to tell Terraform about the failure) and Terraform will taint the resource if the execution fails so it can be run again.