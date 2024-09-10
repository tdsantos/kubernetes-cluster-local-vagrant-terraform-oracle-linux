output "vm_ip_addresses" {
  description = "Endereços IP das VMs"
  value       = virtualbox_vm.node.*.network_adapter.0.ipv4_address
}

output "vm_names" {
  description = "Nomes das VMs"
  value       = virtualbox_vm.node.*.name
}
