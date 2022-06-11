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
output "dc_id" {
    value = data.vsphere_datacenter.dc.id
}