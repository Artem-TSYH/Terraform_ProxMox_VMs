output "proxmox_nodes" {
  value = data.proxmox_virtual_environment_nodes.available_nodes.names
}

output "k8s_node_ips" {
  description = "Real IP addresses of the created Kubernetes nodes"
  value = {
    for vm in proxmox_virtual_environment_vm.k8s_nodes :
    vm.name => try(
      flatten(vm.ipv4_addresses)[1],
      "Waiting for QEMU Agent..."
    )
  }
}