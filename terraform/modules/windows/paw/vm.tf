### Resources ###

# PAW
resource "vsphere_virtual_machine" "paw" {
  name             = var.name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id
  firmware         = var.vm_firmware
  num_cpus         = 2
  memory           = 4096
  guest_id         = var.guest_id
  wait_for_guest_net_timeout = 10
  wait_for_guest_ip_timeout = 10
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
        computer_name         = var.name
        admin_password        = data.vault_generic_secret.password.data["password"]
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = data.vault_generic_secret.password.data["password"]
      }
      network_interface {
        ipv4_address    = var.ipv4_address
        ipv4_netmask    = 24
        dns_server_list = var.dns_server_list
      }
      ipv4_gateway = "192.168.50.1"
      timeout      = 20
    }
  }

  provisioner "local-exec" {
    command = templatefile("${var.template_file}", {
      sleep            = "sleep 30s"
      change_dir       = var.change_dir,
      ansible_user     = "ansible_user=${var.domain_admin_user}@EDEN.LOCAL"
      password         = nonsensitive(data.vault_generic_secret.password.data["password"]),
      extra_args       = "hostname=${var.name}.${var.join_domain}",
      ansible_playbook = var.ansible_playbook
    })
  }
}
