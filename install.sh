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

# --- Symlink helper ---
make_link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        log "Already linked: $(basename "$dst")"
        return
    fi

    if [ -e "$dst" ]; then
        mkdir -p "$BACKUP"
        warn "Backing up: $dst → $BACKUP/"
        cp -a "$dst" "$BACKUP/"
        rm -rf "$dst"
    fi

    # Ensure parent dir exists
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    log "Linked: $dst"
}

# --- Dotfiles ---
link_dotfiles() {
    echo ""
    log "Linking dotfiles from $SURFACE..."

    make_link "$SURFACE/.bashrc"     "$HOME/.bashrc"
    make_link "$SURFACE/.gitconfig"  "$HOME/.gitconfig"

    # _vimrc: link as both _vimrc (alias target) and .vimrc (vim default)
    make_link "$SURFACE/_vimrc"      "$HOME/_vimrc"
    make_link "$SURFACE/_vimrc"      "$HOME/.vimrc"
}

# --- Vundle ---
install_vundle() {
    echo ""
    local vundle_dir="$HOME/.vim/bundle/Vundle.vim"

    if [ -d "$vundle_dir" ]; then
        log "Vundle already installed at $vundle_dir"
        return
    fi

    log "Cloning Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$vundle_dir"
    log "Running :PluginInstall (this may take a moment)..."
    vim +PluginInstall +qall
    log "Vundle plugins installed"
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
        [ -z "$group" ] || [ -z "$pkgs" ] && return
        echo ""
        if confirm "[$group] $desc?"; then
            log "Installing: $pkgs"
            # shellcheck disable=SC2086
            sudo apt install -y $pkgs
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

link_dotfiles
install_vundle
install_starship
install_packages

echo ""
log "All done. Open a new terminal or run: source ~/.bashrc"
