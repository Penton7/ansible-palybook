#!/bin/bash
IP=$(whiptail --title  "Ansible" --inputbox  "Enter ip server" 10 60 3>&1 1>&2 2>&3)
exitstatus=$?

[[ "$exitstatus" = 1 ]] && exit;

KEY=$(whiptail --title  "Ansible" --inputbox  "Enter path to key" 10 60 3>&1 1>&2 2>&3)
exitstatus=$?

[[ "$exitstatus" = 1 ]] && exit;

USER=$(whiptail --title  "Ansible" --inputbox  "Enter user from server" 10 60 3>&1 1>&2 2>&3)
exitstatus=$?

[[ "$exitstatus" = 1 ]] && exit;



echo "[all]
your.server ansible_ssh_host=$IP ansible_ssh_private_key_file=$KEY ansible_ssh_user=$USER" > mashines.lst


DISTROS=$(whiptail --title "Ansible" --checklist \
"Choose ansible roles" 15 70 10 \
"docker" "Install docker and docker-compose" OFF \
"letsencrypt" "Install and configuration letsencrypt" OFF \
"nginx" "Install and configuration nginx" OFF \
"git" "Install git" OFF \
"packages" "Install other packages" OFF 3>&1 1>&2 2>&3)

exitstatus=$?

[[ "$exitstatus" = 1 ]] && exit;


echo "
---
- name: launching roles
  hosts: all
  remote_user: root
  become: yes
  roles:
" > second.playbook.yml

for DISTRO in $DISTROS
do
  echo "    - $DISTRO" >> second.playbook.yml
done

ansible-playbook second.playbook.yml -i mashines.lst
rm second.playbook.yml