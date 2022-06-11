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

# wsus vars
variable "wsus_ipv4_address" {}
variable "wsus_dns_server_list" {
    type = list(string)
}
variable "wsus_ansible_playbook" {}
variable "wsus_name" {}
