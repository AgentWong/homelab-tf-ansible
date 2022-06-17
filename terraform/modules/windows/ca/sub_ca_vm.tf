### Resources ###

# Root CA
resource "vsphere_virtual_machine" "sub_ca" {
  name                 = var.sub_name
  tools_upgrade_policy = upgradeAtPowerCycle
  resource_pool_id     = var.resource_pool_id
  datastore_id         = var.datastore_id
  firmware             = var.vm_firmware
  num_cpus             = 2
  memory               = 4096
  guest_id             = var.guest_id
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
        computer_name         = var.sub_name
        admin_password        = data.vault_generic_secret.password.data["password"]
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = data.vault_generic_secret.password.data["password"]
        auto_logon            = true
        auto_logon_count      = 1
        run_once_command_list = ["cmd.exe /c powershell.exe Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1",
        "cmd.exe /c powershell.exe -ExecutionPolicy Bypass -File ConfigureRemotingForAnsible.ps1"]
      }
      network_interface {
        ipv4_address    = var.sub_ipv4_address
        ipv4_netmask    = 24
        dns_server_list = var.sub_dns_server_list
      }
      ipv4_gateway = "192.168.50.1"
    }
  }

  provisioner "local-exec" {
    command = templatefile("${var.template_file}", {
      sleep            = "sleep 30s"
      change_dir       = var.change_dir,
      ansible_user     = ""
      password         = nonsensitive(data.vault_generic_secret.password.data["password"]),
      extra_args       = "root_ca_hostname=${var.root_name}. sub_ca_hostname=${var.sub_name}.${var.join_domain}",
      ansible_playbook = var.sub_ansible_playbook
    })
  }
  depends_on = [
    vsphere_virtual_machine.root_ca
  ]
}
