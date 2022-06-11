data "terraform_remote_state" "base" {
    backend = "local"
    config = {
        path = "/project/tfstate/vsphere/base/terraform.tfstate"
    }
}