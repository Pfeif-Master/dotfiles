#!/bin/bash
# FoxDen Dotfile Installer
# AI<: initial implementation

set -e

# --- Colors ---
Y=$'\e[1;33m'; G=$'\e[1;32m'; B=$'\e[1;34m'; R=$'\e[1;31m'; RST=$'\e[m'

log()  { echo -e "${G}▸${RST} $*"; }
warn() { echo -e "${Y}⚠${RST}  $*"; }
err()  { echo -e "${R}✘${RST}  $*"; exit 1; }

confirm() {
    local response
    read -r -p "$(echo -e "${B}?${RST}  $1 [y/N] ")" response
    [[ "$response" =~ ^[Yy]$ ]]
}

# --- Paths ---
DOTFILES="$(cd "$(dirname "$0")" && pwd)"
SURFACE="$DOTFILES/surface"
BACKUP="$HOME/.original_dots"
PACKAGES="$DOTFILES/packages.conf"
FIRACODE_INSTALLED=0

# --- Symlink helper (used by install_starship) ---
make_link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        log "Already linked: $(basename "$dst")"
        return
    fi

    if [ -e "$dst" ]; then
        local backup_dst="$BACKUP/$(basename "$dst")"
        if [ -e "$backup_dst" ]; then
            warn "Backup already exists, skipping backup: $backup_dst"
        else
            mkdir -p "$BACKUP"
            warn "Backing up: $dst → $BACKUP/"
            cp -a "$dst" "$BACKUP/"
        fi
        rm -rf "$dst"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    log "Linked: $dst"
}

# --- Vundle ---
install_vundle() {
    echo ""
    local vundle_dir="$HOME/.vim/bundle/Vundle.vim"

    if [ -d "$vundle_dir" ]; then
        log "Vundle already installed at $vundle_dir"
        return
    fi

    log "Installing YCM build dependencies..."
    sudo apt install -y build-essential cmake python3-dev python3-setuptools clangd

    log "Cloning Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$vundle_dir"
    log "Running :PluginInstall (this may take a moment)..."
    vim +PluginInstall +qall
    log "Vundle plugins installed"

    local ycm_dir="$HOME/.vim/bundle/YouCompleteMe"
    if [ -d "$ycm_dir" ]; then
        log "Compiling YouCompleteMe (clangd + rust + python)..."
        python3 "$ycm_dir/install.py" --clangd-completer --rust-completer
        log "YCM compiled"
    else
        warn "YCM directory not found after PluginInstall — skipping compile"
    fi
}

# --- Starship ---
install_starship() {
    echo ""
    if ! confirm "Set up Starship prompt?"; then
        return
    fi

    if command -v starship &>/dev/null; then
        log "Starship already installed ($(starship --version))"
    else
        log "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh
    fi

    # starship.toml lives in the repo — make_link handles backup of any existing config
    mkdir -p "$HOME/.config"
    make_link "$SURFACE/starship.toml" "$HOME/.config/starship.toml"

    # Add init line to .bashrc if missing
    if ! grep -q "starship init bash" "$HOME/.bashrc"; then
        echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
        log "Added starship init to .bashrc"
    else
        log "Starship init already in .bashrc"
    fi
}

# --- FiraCode Nerd Font ---
_is_wsl() { grep -qi microsoft /proc/version 2>/dev/null; }

install_firacode() {
    echo ""
    if ! confirm "Install FiraCode Nerd Font?"; then
        return
    fi

    local font_dir
    if _is_wsl; then
        local win_user
        win_user=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')
        if [ -z "$win_user" ]; then
            warn "Could not detect Windows username — skipping font install"
            return
        fi
        font_dir="/mnt/c/Users/$win_user/AppData/Local/Microsoft/Windows/Fonts"
    else
        font_dir="$HOME/.local/share/fonts/FiraCode"
    fi

    if ls "$font_dir"/FiraCodeNerdFont*.ttf &>/dev/null 2>&1; then
        log "FiraCode Nerd Font already installed"
        return
    fi

    if ! command -v unzip &>/dev/null; then
        log "Installing unzip..."
        sudo apt install -y unzip
    fi

    local tmp
    tmp=$(mktemp -d)
    log "Downloading FiraCode Nerd Font..."
    curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip" \
        -o "$tmp/FiraCode.zip"
    unzip -q "$tmp/FiraCode.zip" -d "$tmp/FiraCode"

    mkdir -p "$font_dir"
    cp "$tmp/FiraCode/"*.ttf "$font_dir/"
    rm -rf "$tmp"

    if _is_wsl; then
        FIRACODE_INSTALLED=1
        log "Installed to $font_dir"
    else
        fc-cache -f "$font_dir"
        log "Installed to $font_dir and font cache refreshed"
    fi
}

# --- WSL utilities ---
install_wsl_utils() {
    _is_wsl || return
    echo ""
    if command -v wslview &>/dev/null; then
        log "wslview already installed"
        return
    fi
    log "WSL detected — installing wslu (wslview)..."
    sudo apt install -y wslu
    log "wslview installed"
}

# --- Packages ---
install_packages() {
    echo ""
    if ! confirm "Install additional packages?"; then
        return
    fi

    if [ ! -f "$PACKAGES" ]; then
        warn "No packages.conf found at $PACKAGES — skipping"
        return
    fi

    local group="" desc="" pkgs="" post=""

    flush_group() {
        [ -z "$group" ] && return
        [ -z "$pkgs" ] && [ -z "$post" ] && return
        echo ""
        if confirm "[$group] $desc?"; then
            if [ -n "$pkgs" ]; then
                log "Installing: $pkgs"
                # shellcheck disable=SC2086
                sudo apt install -y $pkgs
            fi
            if [ -n "$post" ]; then
                log "Running post-install for [$group]..."
                eval "$post"
            fi
        fi
        group=""; desc=""; pkgs=""; post=""
    }

    while IFS= read -r line || [ -n "$line" ]; do
        [[ "$line" =~ ^#.*$|^[[:space:]]*$ ]] && continue

        if [[ "$line" =~ ^\[(.+)\]$ ]]; then
            flush_group
            group="${BASH_REMATCH[1]}"
        elif [[ "$line" =~ ^description=(.*)$ ]]; then
            desc="${BASH_REMATCH[1]}"
        elif [[ "$line" =~ ^packages=(.*)$ ]]; then
            pkgs="${BASH_REMATCH[1]}"
        elif [[ "$line" =~ ^post_install=(.*)$ ]]; then
            post="${BASH_REMATCH[1]}"
        fi
    done < "$PACKAGES"

    flush_group
}

# --- Main ---
echo ""
echo -e "${G}FoxDen Dotfile Installer${RST}"
echo -e "${G}========================${RST}"

echo ""
log "Updating package lists and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

bash "$DOTFILES/link.sh"
install_starship
install_wsl_utils
install_packages
install_firacode
install_vundle

echo ""
log "All done. Open a new terminal or run: source ~/.bashrc"
if [ "$FIRACODE_INSTALLED" -eq 1 ]; then
    echo ""
    warn "Font registration required:"
    warn "  1. Open Explorer → %LOCALAPPDATA%\\Microsoft\\Windows\\Fonts"
    warn "  2. Select all FiraCode TTFs → right-click → Install"
    warn "  3. Set in Windows Terminal: Settings → your profile → Font face → FiraCode Nerd Font"
fi
