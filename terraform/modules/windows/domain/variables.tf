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

# PDC vars
variable "pdc_ipv4_address" {}
variable "pdc_dns_server_list" {
    type = list(string)
}
variable "pdc_ansible_playbook" {}
variable "pdc_name" {}

# RDC vars
variable "rdc_ipv4_address" {}
variable "rdc_dns_server_list" {
    type = list(string)
}
variable "rdc_ansible_playbook" {}
variable "rdc_name" {}

variable "dc_dns_ansible_playbook" {}