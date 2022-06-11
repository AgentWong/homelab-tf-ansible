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
  }
}

inputs = {
  vsphere_dc_name = "Garden"
  vsphere_datastore = "vsanDatastore"
  vsphere_compute_cluster ="EDEN"
  vsphere_portgroup_name = "VM Network"
}