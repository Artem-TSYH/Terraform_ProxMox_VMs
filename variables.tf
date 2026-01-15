variable "node_name" {
  description = "Proxmox node where resources will be created"
  type        = string
}

variable "proxmox_endpoint" {
  type      = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_ssh_key_path" {
  description = "Path to the private SSH key"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  type      = string
}

variable "vm_count" {
  type      = number
  default   = 3
}

variable "vm_id_start" {
  type      = number
  default   = 301
}

variable "proxmox_template_id" {
  type      = number
  default   = 9000
}

variable "vm_resources" {
  description = "Resources: cpu, memory"
  type = object({
    cores  = number
    memory = number
  })
  default = {
    cores  = 2
    memory = 4096
  }
}