resource "vsphere_tag_category" "category" {
  name        = "${var.category_name}"
  description = "Managed by Terraform"
  cardinality = "MULTIPLE"

  associable_types = [
    "VirtualMachine"
  ]
}