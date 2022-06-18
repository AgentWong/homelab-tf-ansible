#VM Guest Win2019 outputs
output "win2019_vm_firmware" {
    value = data.vsphere_virtual_machine.win2019_template.firmware
}
output "win2019_guest_id" {
    value = data.vsphere_virtual_machine.win2019_template.guest_id
}
output "win2019_vm_net_interface_type" {
    value = data.vsphere_virtual_machine.win2019_template.network_interface_types[0]
}
output "win2019_disk_size" {
    value = data.vsphere_virtual_machine.win2019_template.disks.0.size
}
output "win2019_disk_eagerly_scrub" {
    value = data.vsphere_virtual_machine.win2019_template.disks.0.eagerly_scrub
}
output "win2019_disk_thin_provisioned" {
    value = data.vsphere_virtual_machine.win2019_template.disks.0.thin_provisioned
}
output "win2019_scsi_type" {
    value = data.vsphere_virtual_machine.win2019_template.scsi_type
}
output "win2019_template_id" {
    value = data.vsphere_virtual_machine.win2019_template.id
}

#VM Guest Win10 outputs
output "win10_vm_firmware" {
    value = data.vsphere_virtual_machine.win10_template.firmware
}
output "win10_guest_id" {
    value = data.vsphere_virtual_machine.win10_template.guest_id
}
output "win10_vm_net_interface_type" {
    value = data.vsphere_virtual_machine.win10_template.network_interface_types[0]
}
output "win10_disk_size" {
    value = data.vsphere_virtual_machine.win10_template.disks.0.size
}
output "win10_disk_eagerly_scrub" {
    value = data.vsphere_virtual_machine.win10_template.disks.0.eagerly_scrub
}
output "win10_disk_thin_provisioned" {
    value = data.vsphere_virtual_machine.win10_template.disks.0.thin_provisioned
}
output "win10_scsi_type" {
    value = data.vsphere_virtual_machine.win10_template.scsi_type
}
output "win10_template_id" {
    value = data.vsphere_virtual_machine.win10_template.id
}