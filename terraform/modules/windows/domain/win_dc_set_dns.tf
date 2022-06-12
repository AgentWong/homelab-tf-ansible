resource "null_resource" "set_dc_dns" {
  provisioner "local-exec" {
    command = templatefile("${var.template_file}", { 
      sleep = "",
      change_dir = var.change_dir, 
      ansible_user = "${var.domain_admin_user}@EDEN.LOCAL"
      password = nonsensitive(data.vault_generic_secret.password.data["password"]),
      extra_args = "pdc_hostname=${var.pdc_name}.${var.join_domain} rdc_hostname=${var.rdc_name}.${var.join_domain}",
      ansible_playbook = var.dc_dns_ansible_playbook
      })
  }
  depends_on = [
    vsphere_virtual_machine.pdc,
    vsphere_virtual_machine.rdc
  ]
}
