include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//windows/paw"

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
  vm_firmware           = dependency.windows_vm_template.outputs.win10_vm_firmware
  guest_id              = dependency.windows_vm_template.outputs.win10_guest_id
  vm_net_interface_type = dependency.windows_vm_template.outputs.win10_vm_net_interface_type
  disk_size             = dependency.windows_vm_template.outputs.win10_disk_size
  disk_eagerly_scrub    = dependency.windows_vm_template.outputs.win10_disk_eagerly_scrub
  disk_thin_provisioned = dependency.windows_vm_template.outputs.win10_disk_thin_provisioned
  scsi_type             = dependency.windows_vm_template.outputs.win10_scsi_type
  template_id           = dependency.windows_vm_template.outputs.win10_template_id

  change_dir = "${get_parent_terragrunt_dir()}/../../ansible"

  template_file = "${get_parent_terragrunt_dir()}/../templates/run_playbook.tftpl"

  # PAW vars
  ipv4_address     = "192.168.50.101"
  dns_server_list  = ["192.168.50.71", "192.168.50.72"]
  ansible_playbook = "windows-setup-paw-w10.yml"
  name             = "EDEN-PAW-01"
}