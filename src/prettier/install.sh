#!/usr/bin/env bash
set -e

export SUCCESS=0
FEATURE="prettier"
VERSION_TO_INSTALL=${VERSION:-"latest"}


run() {
    . "$(dirname "$0")"/ensure.sh && ensure 'curl bash'

    echo "Installing… Prettier"
    echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

    # CONTRIB_INSTALL_SCRIPTS_URL=https://raw.githubusercontent.com/devcontainers-contrib/features/main/script-library/install-scripts.sh
    # . <(curl "$CONTRIB_INSTALL_SCRIPTS_URL") # :careful to source trusted code!
    # install_via_npm "prettier" # come from devcontainers-contrib install-script

    ROOT_USER_ID=0
    [ "$(id -u)" -ne $ROOT_USER_ID ] && privileges="sudo "

    ${privileges}curl -Lo /usr/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
    ${privileges}chmod 755 /usr/bin/pacapt
    ${privileges}pacapt update
    ${privileges}pacapt install --noconfirm nodejs

    echo "The provided $FEATURE version is: $VERSION_TO_INSTALL"
}

run