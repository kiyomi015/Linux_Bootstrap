set dotenv-load := false
set shell := ["bash", "-cu"]

ANSIBLE := "ansible-playbook"
ANSIBLE_CONFIG := "ansible/ansible.cfg"
INVENTORY := "ansible/inventory/hosts.yml"

up:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/site.yml -K

install: up

zsh:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/zsh.yml -K

nvim:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/nvim.yml -K

packages:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/packages.yml -K

check:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/site.yml -K --check --diff
