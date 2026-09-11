# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

set -gx EDITOR nvim
set -gx VISUAL nvim

fish_add_path $HOME/.local/bin

# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
