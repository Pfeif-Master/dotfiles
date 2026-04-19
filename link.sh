#!/bin/bash
# FoxDen Symlinker — safe to run repeatedly

set -e

Y=$'\e[1;33m'; G=$'\e[1;32m'; R=$'\e[1;31m'; RST=$'\e[m'

log()  { echo -e "${G}▸${RST} $*"; }
warn() { echo -e "${Y}⚠${RST}  $*"; }

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
SURFACE="$DOTFILES/surface"
BACKUP="$HOME/.original_dots"

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

echo ""
log "Linking dotfiles from $SURFACE..."

make_link "$SURFACE/.bashrc"    "$HOME/.bashrc"
make_link "$SURFACE/.gitconfig" "$HOME/.gitconfig"
make_link "$SURFACE/_vimrc"     "$HOME/_vimrc"
make_link "$SURFACE/_vimrc"     "$HOME/.vimrc"

echo ""
log "Done."
