# desktopBootstrap

Opinionated desktop bootstrap for Linux using Ansible + Just.

## Quick start

```bash
just install
```

Other targets:

```bash
just up
just packages
just zsh
just nvim
```

## Layout

- `ansible/`
  - `playbooks/` entry points
  - `roles/` all roles (packages, zsh, nvim)
- `justfile` task runner

## Configuration

Primary defaults live in:

- `ansible/roles/packages_setup/defaults/main.yml`
- `ansible/roles/zsh_setup/defaults/main.yml`
- `ansible/roles/nvim_setup/defaults/main.yml`

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
- `zsh_setup` sets Zsh as the default shell for `bootstrap_user`.

## Requirements

- Ansible installed on the host
- `just` installed for task running
