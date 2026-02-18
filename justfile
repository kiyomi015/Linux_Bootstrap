set dotenv-load := false
set shell := ["bash", "-cu"]

ANSIBLE := "ansible-playbook"
ANSIBLE_CONFIG := "ansible/ansible.cfg"
INVENTORY := "ansible/inventory/hosts.yml"

DOTFILES_REPO := env_var("DOTFILES_REPO", "")
DOTFILES_SOURCE := env_var("DOTFILES_SOURCE", "../dotfiles")
DOTFILES_COMMIT_MSG := env_var("DOTFILES_COMMIT_MSG", "Update dotfiles")

bootstrap:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} DOTFILES_REPO={{DOTFILES_REPO}} DOTFILES_SOURCE={{DOTFILES_SOURCE}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/site.yml -K

install: bootstrap
up: bootstrap

packages:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/packages.yml -K

zsh:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/zsh.yml -K

dotfiles:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} DOTFILES_REPO={{DOTFILES_REPO}} DOTFILES_SOURCE={{DOTFILES_SOURCE}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/dotfiles.yml -K

dotfiles-apply:
  if chezmoi source-path >/dev/null 2>&1; then
    chezmoi apply
  elif [ -n "{{DOTFILES_REPO}}" ]; then
    chezmoi init --apply "{{DOTFILES_REPO}}"
  elif [ -d "{{DOTFILES_SOURCE}}" ]; then
    chezmoi init --apply --source "{{DOTFILES_SOURCE}}"
  else
    echo "Set DOTFILES_REPO or ensure DOTFILES_SOURCE exists"; exit 1
  fi

dotfiles-add +paths:
  chezmoi add {{paths}}

dotfiles-push:
  cd "$(chezmoi source-path)" && git add -A && if git diff --cached --quiet; then echo "No changes"; else git commit -m "{{DOTFILES_COMMIT_MSG}}" && git push; fi

check:
  ANSIBLE_CONFIG={{ANSIBLE_CONFIG}} {{ANSIBLE}} -i {{INVENTORY}} ansible/playbooks/site.yml -K --check --diff
