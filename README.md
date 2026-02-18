# desktopBootstrap

System bootstrap repo using Ansible + Just. This repo is responsible for system state: packages, repos, and base system configuration.

## Repos

- `desktopBootstrap/` (this repo): system convergence
- `dotfiles/` (sibling repo): chezmoi source for user configs

## Quick start

```bash
DOTFILES_REPO=git@github.com:you/dotfiles.git just bootstrap
```

Or use the sibling repo:

```bash
just bootstrap
```

## How it works

- Ansible installs packages, repos, and system defaults.
- Chezmoi applies user dotfiles from the sibling repo or a git URL.
- Optional dotfiles bootstrap hook runs after apply for user-level setup.

## Just targets

```bash
just bootstrap
just packages
just zsh
just dotfiles
just dotfiles-apply
just dotfiles-add ~/.zshrc ~/.config/...
just dotfiles-push
```

## Layout

- `ansible/`
  - `playbooks/` entry points
  - `roles/` system roles (packages, zsh, dotfiles)
- `justfile` task runner

## Configuration

Defaults live in:

- `ansible/roles/packages_setup/defaults/main.yml`
- `ansible/roles/zsh_setup/defaults/main.yml`
- `ansible/roles/dotfiles_setup/defaults/main.yml`

Common changes:

- Enable/disable Flatpak apps in `flatpak_apps`.
- Choose Ghostty source on Fedora:
  - `ghostty_fedora_source: copr` (default)
  - `ghostty_fedora_source: terra`
- Control Ghostty install method:
  - `ghostty_install_method: auto | copr | terra | package | snap`

## Notes

- The `site.yml` playbook runs all roles in order.
- `packages_setup` performs package installs, repo setup, and upgrades.
- `dotfiles_setup` runs `chezmoi init --apply` (first run) or `chezmoi apply` (subsequent runs).

## Requirements

- Ansible installed on the host
- `just` recommended for task running
- `chezmoi` for dotfiles

## Next steps (suggestions)

1. Add a `desktop` package group in `packages_setup` for Hyprland stack packages.
2. Add per-host inventories (`laptop`, `server`, `workstation`) to control package sets.
3. Add a secrets strategy (Ansible Vault or `age` in dotfiles).
