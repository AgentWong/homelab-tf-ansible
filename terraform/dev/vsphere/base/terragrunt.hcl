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