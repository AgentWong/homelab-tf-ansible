### Resources ###

# Primary DC
resource "vsphere_virtual_machine" "wsus" {
  name             = var.wsus_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  firmware         = data.vsphere_virtual_machine.template.firmware
  num_cpus         = 2
  memory           = 4096
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      windows_options {
        computer_name         = var.wsus_name
        admin_password        = var.admin_password
        domain_join           = var.domain_join
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
        auto_logon            = true
        auto_logon_count      = 1
        run_once_command_list = ["cmd.exe /c powershell.exe Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1",
        "cmd.exe /c powershell.exe -ExecutionPolicy Bypass -File ConfigureRemotingForAnsible.ps1"]
      }
      network_interface {
        ipv4_address    = var.wsus_ipv4_address
        ipv4_netmask    = 24
        dns_server_list = var.wsus_dns_server_list
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
      ansible-playbook --extra-vars 'wsus_hostname=${var.wsus_name}' ${var.wsus_ansible_playbook}; exit_test $?
      EOT
  }
}