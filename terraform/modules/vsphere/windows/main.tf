# Base config

# Fetch template vm data
data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template_name}"
  datacenter_id = "${data.terraform_remote_state.base.outputs.dc_id}"
}