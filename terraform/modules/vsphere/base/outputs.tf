#Common Outputs
output "resource_pool_id" {
    value = data.vsphere_compute_cluster.cluster.resource_pool_id
}
output "datastore_id" {
    value = data.vsphere_datastore.datastore.id
}
output "network_id" {
    value = data.vsphere_network.network.id
}

#VM Guest outputs
output "vm_firmware" {
    value = data.vsphere_virtual_machine.template.firmware
}
output "guest_id" {
    value = data.vsphere_virtual_machine.template.guest_id
}
output "vm_net_interface_type" {
    value = data.vsphere_virtual_machine.template.network_interface_types[0]
}
output "disk_size" {
    value = data.vsphere_virtual_machine.template.disks.0.size
}
output "disk_eagerly_scrub" {
    value = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
}
output "disk_thin_provisioned" {
    value = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
}
output "scsi_type" {
    value = data.vsphere_virtual_machine.template.scsi_type
}
output "template_id" {
    value = data.vsphere_virtual_machine.template.id
}