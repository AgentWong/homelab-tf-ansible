# Base config

# Fetch template vm data
data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template_name}"
  datacenter_id = "${var.dc_id}"
}