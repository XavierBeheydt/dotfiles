# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function up --description 'Upgrade Arch, AUR and Flatpak packages (see also: updates)'
    argparse h/help 'no-aur' 'no-flatpak' -- $argv; or return 1

    if set -q _flag_help
        echo "usage: up [--no-aur] [--no-flatpak]"
        echo "  Upgrades official repos + AUR (paru), then Flatpak (system and user)."
        echo "  --no-aur       official repos only (sudo pacman -Syu)"
        echo "  --no-flatpak   skip Flatpak"
        echo "  Run 'updates' first to see what is pending."
        return 0
    end

    if set -q _flag_no_aur
        sudo pacman -Syu; or return $status
    else
        paru -Syu; or return $status
    end

    if not set -q _flag_no_flatpak; and command -q flatpak
        flatpak update --system -y; or return $status
        flatpak update --user -y; or return $status
    end
end
