variable "proxmox_endpoint" {
  type      = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
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
  default   = 901
}