# Common vars
variable "change_dir" {}
variable "resource_pool_id" {}
variable "datastore_id" {}
variable "network_id" {}
variable "dc_id" {}
variable "join_domain" {}
variable "domain_admin_user" {}

# VM Guest vars
variable "vm_firmware" {}
variable "guest_id" {}
variable "vm_net_interface_type" {}
variable "disk_size" {}
variable "disk_eagerly_scrub" {}
variable "disk_thin_provisioned" {}
variable "scsi_type" {}
variable "template_id" {}

# Template file path
variable "template_file" {}

# PDC vars
variable "ipv4_address" {}
variable "dns_server_list" {
    type = list(string)
}
variable "ansible_playbook" {}
variable "name" {}