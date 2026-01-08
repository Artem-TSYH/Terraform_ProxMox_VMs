output "proxmox_nodes" {
  value = data.proxmox_virtual_environment_nodes.available_nodes.names
}

output "k8s_node_ips" {
  description = "IP addresses of the created Kubernetes nodes"
  value = {
    for vm in proxmox_virtual_environment_vm.k8s_nodes :
    vm.name => vm.initialization[0].ip_config[0].ipv4[0].address
  }
}