include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//vsphere/tag_category"

  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = ["${get_parent_terragrunt_dir()}/common.tfvars"]
  }
}

inputs = {
  change_dir = "${get_parent_terragrunt_dir()}/../../ansible"
  # PDC vars
  pdc_ipv4_address     = "192.168.50.71"
  pdc_dns_server_list  = ["192.168.50.1"]
  pdc_ansible_playbook = "windows-setup-pdc.yml"
  pdc_name             = "EDEN-DC-01"

  # RDC vars
  rdc_ipv4_address     = "192.168.50.72"
  rdc_dns_server_list  = ["192.168.50.71"]
  rdc_ansible_playbook = "windows-setup-rdc.yml"
  rdc_name             = "EDEN-DC-02"

  dc_dns_ansible_playbook = "windows-dc-dns-client.yml"
}