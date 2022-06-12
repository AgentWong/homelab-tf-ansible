resource "null_resource" "set_dc_dns" {
  provisioner "local-exec" {
    command = <<EOT
      exit_test () {
        RED='\033[0;31m' # Red Text
        GREEN='\033[0;32m' # Green Text
        BLUE='\033[0;34m' # Blue Text
        NC='\033[0m' # No Color
        if [ $1 -eq 0 ]; then
          printf "\n $GREEN Playbook Succeeded $NC \n"
        else
          printf "\n $RED Failed Playbook $NC \n" >&2
          exit 1
        fi
      }
      pwd
      cd ${var.change_dir}
      ansible-playbook --extra-vars 'pdc_hostname=${var.pdc_name} rdc_hostname=${var.rdc_name}' ${var.dc_dns_ansible_playbook}; exit_test $?
      EOT
  }
  depends_on = [
    vsphere_virtual_machine.pdc,
    vsphere_virtual_machine.rdc
  ]
}
