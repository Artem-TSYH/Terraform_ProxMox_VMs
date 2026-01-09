## # Preparing VM for Terraform Automation (Proxmox + Ubuntu) ##
#### # Proxmox VE 8.4.14, Base OS: Ubuntu 24.04.3 LTS (Noble), Terraform v.1.14.3, provider: bpg ####
### # 1. Install & Enable Agent ###
##### # Agent is required for Proxmox to see VM IP and for Terraform to finish 'apply' ####
##### # Documentation: https://pve.proxmox.com/wiki/Qemu-guest-agent ####
##### # NOTE. Run all commands as root. Ensure no other users exist on the VM to keep the template clean. ####

apt update && apt install qemu-guest-agent -y

systemctl start qemu-guest-agent

systemctl enable qemu-guest-agent

systemctl status qemu-guest-agent

### # 2. Check Status ###
##### # IMPORTANT: If agent is 'inactive' or 'failed' ####

poweroff

##### # In Proxmox GUI: VM -> Options -> QEMU Guest Agent -> Edit and "Enabled" -> OK ####
##### # Power on VM ####

systemctl status qemu-guest-agent

### # 3. Cleanup ###

cloud-init clean --logs

rm -f /var/lib/dbus/machine-id

truncate -s 0 /etc/machine-id

poweroff

### # 4. Template ###

##### # In Proxmox GUI: VM -> Convert to template ####
##### # VM ID -> proxmox_template_id in variables.tf ####
