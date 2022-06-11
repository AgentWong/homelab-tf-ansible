resource "vsphere_tag" "tag" {
  for_each    = toset(var.tag_names)
  name        = each.value
  category_id = var.category_id
  description = "Managed by Terraform"
}
