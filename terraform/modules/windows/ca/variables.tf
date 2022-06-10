# Common vars
variable "admin_password" {}
variable "change_dir" {}
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_dc_name" {}
variable "vsphere_datastore" {}
variable "vsphere_compute_cluster" {}
variable "vsphere_portgroup_name" {}
variable "vsphere_template_name" {}
variable "join_domain" {}
variable "domain_admin_user" {}
variable "domain_admin_password" {}

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