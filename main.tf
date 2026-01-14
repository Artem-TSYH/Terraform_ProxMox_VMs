data "proxmox_virtual_environment_nodes" "available_nodes" {}

resource "proxmox_virtual_environment_file" "cloudinit" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "southpark"

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - name: ansible
        groups: sudo
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        ssh_authorized_keys:
          - ${var.ssh_public_key}
    packages:
      - qemu-guest-agent

    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
    EOF

    file_name = "cloudinit.yaml"
  }
}

# VMs for Kubernetes-Cluster
resource "proxmox_virtual_environment_vm" "k8s_nodes" {
  count     = var.vm_count
  name      = "k8s-node-${count.index + 1}"
  node_name = "southpark"
  vm_id     = var.vm_id_start + count.index # for IDs 301, 302, 303
  scsi_hardware = "virtio-scsi-pci"

  clone {
    vm_id = var.proxmox_template_id
    full = true
  }

  boot_order = ["scsi0", "scsi2"]

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "host"
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
  }

  initialization {
    datastore_id = "local-zfs"
    interface    = "scsi2"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.cloudinit.id
  }
}