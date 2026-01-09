# Migrated to OpenTofu
# Tool-Versions due to 2026-01-09

terraform {
  required_version = "~> 1.11.2" #OpenTofu

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.91.0"
    }
  }
}