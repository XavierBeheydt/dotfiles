# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function update --description 'List pending updates (Arch, AUR, Flatpak) without installing anything'
    set -l total 0

    # Official repositories: checkupdates works on a temporary copy of the
    # sync databases, so it never leaves the system in a partial-upgrade state.
    if command -q checkupdates
        set -l arch (checkupdates 2>/dev/null)
        set total (math $total + (count $arch))
        _update_section "Arch (official repos)" $arch
    else
        echo "Arch: checkupdates not found (install pacman-contrib)" >&2
    end

    if command -q paru
        set -l aur (paru -Qua 2>/dev/null)
        set total (math $total + (count $aur))
        _update_section "AUR" $aur
    end

    if command -q flatpak
        set -l flat (flatpak remote-ls --updates --columns=application,version,origin 2>/dev/null)
        set total (math $total + (count $flat))
        _update_section "Flatpak" $flat
    end

    echo
    echo "Total: $total pending update(s)"

    # Packages matching IgnorePkg are never reported as upgradable by pacman,
    # so list the patterns to make clear what is held back.
    set -l held (pacman-conf IgnorePkg 2>/dev/null)
    if test (count $held) -gt 0
        set_color yellow
        echo "Held back by IgnorePkg (not counted above): $held"
        set_color normal
    end
end

# Print a titled block with a count, or a short "up to date" line when empty.
function _update_section --argument-names title
    set -e argv[1]
    set_color --bold cyan
    echo "== $title: "(count $argv)
    set_color normal
    if test (count $argv) -eq 0
        echo "  up to date"
    else
        printf '  %s\n' $argv
    end
end
