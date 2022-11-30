#!/usr/bin/env bash
set -e

export BATS_VERSION # version/git tag to use
export SUCCESS=0

set_version_to_use() {
    VERSION=${VERSION:-"latest"}

    if [ "$VERSION" = 'latest' ]; then 
        echo "master"
        exit "$SUCCESS"
    fi
    echo $VERSION
}

install_bats() {
    GIT_TAG=${1:-master}
    CLONE_DIR=${2:-$HOME}

    echo "Clonig bats-core"

    git clone https://github.com/bats-core/bats-core.git "$CLONE_DIR/bats-core" \
        && cd "$CLONE_DIR/bats-core" \
        && git checkout "$GIT_TAG" \
        && ./install.sh "$HOME"
}

run() {
    echo "Installing… Bats (Bash Automated Testing System)"

    BATS_VERSION=$(set_version_to_use)
    echo "The provided Bats version is: $BATS_VERSION"

    install_bats "$BATS_VERSION"
}

run