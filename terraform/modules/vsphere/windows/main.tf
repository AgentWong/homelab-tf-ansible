# Base config

# Fetch template vm data
data "vsphere_virtual_machine" "win2019_template" {
  name          = "${var.vsphere_win2019_template_name}"
  datacenter_id = "${var.dc_id}"
}
data "vsphere_virtual_machine" "win10_template" {
  name          = "${var.vsphere_win10_template_name}"
  datacenter_id = "${var.dc_id}"
}