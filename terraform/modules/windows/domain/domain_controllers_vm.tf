### Resources ###

# Primary DC
resource "vsphere_virtual_machine" "pdc" {
  name             = var.pdc_name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id
  firmware         = var.vm_firmware
  num_cpus         = 2
  memory           = 4096
  guest_id         = var.guest_id
  network_interface {
    network_id   = var.network_id
    adapter_type = var.vm_net_interface_type
  }
  disk {
    label            = "disk0"
    size             = var.disk_size
    eagerly_scrub    = var.disk_eagerly_scrub
    thin_provisioned = var.disk_thin_provisioned
  }
  scsi_type = var.scsi_type

  clone {
    template_uuid = var.template_id
    customize {
      windows_options {
        computer_name    = var.pdc_name
        admin_password   = data.vault_generic_secret.password.data["password"]
        workgroup        = "WORKGROUP"
        auto_logon       = true
        auto_logon_count = 1
        run_once_command_list = ["cmd.exe /c powershell.exe Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1",
        "cmd.exe /c powershell.exe -ExecutionPolicy Bypass -File ConfigureRemotingForAnsible.ps1",
        "cmd.exe /c powershell.exe Enable-WSManCredSSP -Role Server -Force"]
      }
      network_interface {
        ipv4_address    = var.pdc_ipv4_address
        ipv4_netmask    = 24
        dns_server_list = var.pdc_dns_server_list
      }
      ipv4_gateway = "192.168.50.1"
    }
  }

  provisioner "local-exec" {
    command = templatefile("${var.template_file}", { 
      change_dir = var.change_dir, 
      password = data.vault_generic_secret.password.data["password"],
      hostnames = "pdc_hostname=${var.pdc_name}",
      ansible_playbook = var.pdc_ansible_playbook
      })
  }
}

# Replica DC
resource "vsphere_virtual_machine" "rdc" {
  name             = var.rdc_name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id
  firmware         = var.vm_firmware
  num_cpus         = 2
  memory           = 4096
  guest_id         = var.guest_id
  network_interface {
    network_id   = var.network_id
    adapter_type = var.vm_net_interface_type
  }
  disk {
    label            = "disk0"
    size             = var.disk_size
    eagerly_scrub    = var.disk_eagerly_scrub
    thin_provisioned = var.disk_thin_provisioned
  }
  scsi_type = var.scsi_type

  clone {
    template_uuid = var.template_id
    customize {
      windows_options {
        computer_name         = var.rdc_name
        admin_password        = data.vault_generic_secret.password.data["password"]
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = data.vault_generic_secret.password.data["password"]
        auto_logon            = true
        auto_logon_count      = 1
        run_once_command_list = ["cmd.exe /c powershell.exe Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1",
        "cmd.exe /c powershell.exe -ExecutionPolicy Bypass -File ConfigureRemotingForAnsible.ps1",
        "cmd.exe /c powershell.exe Enable-WSManCredSSP -Role Server -Force"]
      }
      network_interface {
        ipv4_address    = var.rdc_ipv4_address
        ipv4_netmask    = 24
        dns_server_list = var.rdc_dns_server_list
      }
      ipv4_gateway = "192.168.50.1"
    }
  }

  provisioner "local-exec" {
    command = <<EOT
      exit_test () {
        RED='\033[0;31m' # Red Text
        GREEN='\033[0;32m' # Green Text
        BLUE='\033[0;34m' # Blue Text
        NC='\033[0m' # No Color
        if [ $1 -eq 0 ]; then
          printf "\n $GREEN Playbook Succeeded $NC \n"
        else
          printf "\n $RED Failed Playbook $NC \n" >&2
          exit 1
        fi
      }
      cd ${var.change_dir}
      ansible-playbook --extra-vars 'pdc_hostname=${var.pdc_name} rdc_hostname=${var.rdc_name} \
      ansible_user=administrator ansible_password=${data.vault_generic_secret.password.data["password"]} \
      password=${data.vault_generic_secret.password.data["password"]}' \
       ${var.rdc_ansible_playbook}; exit_test $?
      EOT
  }
  depends_on = [
    vsphere_virtual_machine.pdc
  ]
}