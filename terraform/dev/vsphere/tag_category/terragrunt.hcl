include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//vsphere/tag_category"

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
    category_name = "Role"
  }