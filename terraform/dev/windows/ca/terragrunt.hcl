include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//windows/ca"

  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = ["${get_parent_terragrunt_dir()}/common.tfvars"]
  }
}
dependency "vsphere_base" {
  config_path = "../../vsphere/base"
}
dependency "windows_vm_template" {
  config_path = "../../vsphere/windows"
}

dependencies {
  paths = ["../ad"]
}

inputs = {
  ### Dependencies ###
  # Base
  resource_pool_id = dependency.vsphere_base.outputs.resource_pool_id
  datastore_id     = dependency.vsphere_base.outputs.datastore_id
  network_id       = dependency.vsphere_base.outputs.network_id
  dc_id            = dependency.vsphere_base.outputs.dc_id

  # VM Guest
  vm_firmware           = dependency.windows_vm_template.outputs.win2019_vm_firmware
  guest_id              = dependency.windows_vm_template.outputs.win2019_guest_id
  vm_net_interface_type = dependency.windows_vm_template.outputs.win2019_vm_net_interface_type
  disk_size             = dependency.windows_vm_template.outputs.win2019_disk_size
  disk_eagerly_scrub    = dependency.windows_vm_template.outputs.win2019_disk_eagerly_scrub
  disk_thin_provisioned = dependency.windows_vm_template.outputs.win2019_disk_thin_provisioned
  scsi_type             = dependency.windows_vm_template.outputs.win2019_scsi_type
  template_id           = dependency.windows_vm_template.outputs.win2019_template_id

  change_dir = "${get_parent_terragrunt_dir()}/../../ansible"

  template_file = "${get_parent_terragrunt_dir()}/../templates/run_playbook.tftpl"

  # ROOT CA vars
  root_ipv4_address     = "192.168.50.73"
  root_dns_server_list  = ["192.168.50.71", "192.168.50.72"]
  root_ansible_playbook = "windows-setup-root-ca.yml"
  root_name             = "EDEN-ROOT-CA"

  # SUB CA vars
  sub_ipv4_address     = "192.168.50.74"
  sub_dns_server_list  = ["192.168.50.71", "192.168.50.72"]
  sub_ansible_playbook = "windows-setup-sub-ca.yml"
  sub_name             = "EDEN-CA-01"
}