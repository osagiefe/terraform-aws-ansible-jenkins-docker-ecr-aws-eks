#!/bin/bash
sudo apt-add-repository ppa:ansible/ansible
enter
sudo apt update
sudo apt install ansible -y
ansible --version