# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

# List available recipes
default:
    @just --list

# Refresh pkg.list from explicitly installed packages (official + AUR)
update-pkglist:
    #!/usr/bin/env bash
    set -euo pipefail
    paru -Qqe | LC_ALL=C sort > pkg.list
    git --no-pager diff --stat -- pkg.list
