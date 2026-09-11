# dotfiles

Personal system configuration for **Arch Linux + Hyprland (Wayland) +
Quickshell** — somewhere between a plain dotfiles repo and a small Linux
distribution: `home/` config files, selected `/etc` files, and the
installed package list.

**Status: rebuilding from scratch.** The base architecture and tooling are
in place; actual dotfiles under `home/.config/` and `etc/` are being
re-added one at a time (tracked on the [Project
board](https://github.com/users/XavierBeheydt/projects/16)) instead of in
one big drop.

## Layout

- `home/` — symlinked into `$HOME` by `bootstrap` (see below);
  `home/.local/bin/` holds this repo's own tooling scripts
- `etc/` — copied (never symlinked) into `/etc`, root only, via `bootstrap`
- `pkg.list` — `pacman -Qqe` (or `paru -Qqe` for AUR packages too) snapshot
  of installed packages
- `permissions.conf` — owner/group/mode restored on deploy, see
  `dotfiles add <path>`
- `docs/` — reference material for working on this repo

## Setup

```sh
./home/.local/bin/bootstrap            # links home/ into $HOME
sudo ./home/.local/bin/bootstrap       # also deploys etc/ into /etc
```

## Roadmap & docs

- Planned work: [Project board](https://github.com/users/XavierBeheydt/projects/16)
  ([Issues](https://github.com/XavierBeheydt/dotfiles/issues) list underneath it)
- Working conventions (branching, commits, code style): see
  [CLAUDE.md](CLAUDE.md) / [AGENTS.md](AGENTS.md)
- Architecture notes: [docs/](docs/)
