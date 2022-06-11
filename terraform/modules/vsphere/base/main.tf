# Base config

# Fetch datacenter data
data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_dc_name}"
}

# Fetch datastore cluster data
data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Fetch compute cluster data
data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_compute_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Fetch port group data
data "vsphere_network" "network" {
  name          = "${var.vsphere_portgroup_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}