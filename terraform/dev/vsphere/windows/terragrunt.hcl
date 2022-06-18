include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//vsphere/windows"

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
dependency "vsphere_base" {
  config_path = "../base"
}
inputs = {
  vsphere_win2019_template_name = "win-2019-datacenter-core-template"
  vsphere_win10_template_name   = "win-2019-datacenter-gui-template"
  dc_id                         = dependency.vsphere_base.outputs.dc_id
}
