include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//vsphere/tags"

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
dependency "tag_category" {
  config_path = "../tag_category"
}
inputs = {
    category_id = dependency.tag_category.outputs.category_id
    tag_names = ["Domain Controller", "File Server"]
  }