include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//vsphere/base"

  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = ["terraform.tfvars"]
  }
}

inputs = {
  vsphere_user = var.vsphere_user
  vsphere_server = var.vsphere_server
  vsphere_dc_name = var.vsphere_dc_name
  vsphere_datastore = var.vsphere_datastore
  vsphere_compute_cluster = var.vsphere_compute_cluster
  vsphere_portgroup_name = var.vsphere_portgroup_name
  vsphere_template_name = var.vsphere_template_name
}