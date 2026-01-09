data "proxmox_virtual_environment_nodes" "available_nodes" {}

# VMs for Kubernetes-Cluster
resource "proxmox_virtual_environment_vm" "k8s_nodes" {
  count     = var.vm_count
  name      = "k8s-node-${count.index + 1}"
  node_name = "southpark"
  vm_id     = var.vm_id_start + count.index # for IDs 301, 302, 303
  scsi_hardware = "virtio-scsi-pci"

  clone {
    vm_id = var.proxmox_template_id
  }

  boot_order = ["scsi0", "scsi2"]

  agent {
    enabled = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-zfs"
    interface    = "scsi0"
    size         = 32
    file_format  = "raw"
  }

  initialization {
    datastore_id = "local-zfs"
    interface    = "scsi2"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    # Account for Ansible
    user_account {
      username = "ansible"
      keys     =  [var.ssh_public_key]
    }
  }
}