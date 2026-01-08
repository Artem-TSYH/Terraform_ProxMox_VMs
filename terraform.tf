# Tool-Versions due to 2026-01-08

terraform {
  required_version = "~> 1.14.3"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.91.0"
    }
  }
}