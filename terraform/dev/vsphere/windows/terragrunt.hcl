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

inputs = {
    vsphere_template_name = "win-2019-datacenter-core-template"
  }