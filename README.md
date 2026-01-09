## # Preparing VM for Terraform Automation (Proxmox + Ubuntu) ##
#### # Proxmox VE 8.4.14, Base OS: Ubuntu 24.04.3 LTS (Noble), Terraform v.1.14.3, provider: bpg ####
### # 1. Install & Enable Agent ###
##### # Agent is required for Proxmox to see VM IP and for Terraform to finish 'apply' ####
##### # Documentation: https://pve.proxmox.com/wiki/Qemu-guest-agent ####

sudo apt update && sudo apt install qemu-guest-agent -y

sudo systemctl start qemu-guest-agent

sudo systemctl enable qemu-guest-agent

sudo systemctl status qemu-guest-agent

### # 2. Check Status ###
##### # IMPORTANT: If agent is 'inactive' or 'failed' ####

sudo poweroff

##### # In Proxmox GUI: VM -> Options -> QEMU Guest Agent -> Edit and "Enabled" -> OK ####
##### # Power on VM ####

sudo systemctl status qemu-guest-agent

### # 3. Cleanup ###

sudo cloud-init clean --logs

sudo rm /var/lib/dbus/machine-id

sudo truncate -s 0 /etc/machine-id

sudo poweroff

### # 4. Template ###

##### # In Proxmox GUI: VM -> Convert to template ####
##### # VM ID -> proxmox_template_id in variables.tf ####
