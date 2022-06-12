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

# Root CA vars
variable "root_ipv4_address" {}
variable "root_dns_server_list" {
    type = list(string)
}
variable "root_ansible_playbook" {}
variable "root_name" {}

# Sub CA vars
variable "sub_ipv4_address" {}
variable "sub_dns_server_list" {
    type = list(string)
}
variable "sub_ansible_playbook" {}
variable "sub_name" {}