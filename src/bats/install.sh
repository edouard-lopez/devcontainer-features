#!/usr/bin/env sh
set -e

export BATS_VERSION # version/git tag to use
export SUCCESS=0

set_version_to_use() {
    VERSION=${VERSION:-"latest"}

    if [ "$VERSION" = 'latest' ]; then 
        echo "master"
        exit "$SUCCESS"
    fi
    echo "$VERSION"
}

install_bats() {
    GIT_TAG=${1:-master}
    CLONE_DIR=${2:-$_REMOTE_USER_HOME}

    echo "Cloning bats-core"

    git clone https://github.com/bats-core/bats-core.git \
        --branch "$GIT_TAG" \
        "$CLONE_DIR/bats-core" \
    && cd "$CLONE_DIR/bats-core" \
    && ./install.sh "$_REMOTE_USER_HOME"
}

add_bats_to_PATH() {
    export PATH="${_REMOTE_USER_HOME}/bin:$PATH"
    echo 'export PATH="$HOME/bin:$PATH"' >> ${_REMOTE_USER_HOME}/.bashrc
    echo 'export PATH="$HOME/bin:$PATH"' >> ${_REMOTE_USER_HOME}/.profile
}

run() {
    . ./ensure.sh && ensure 'git ca-certificates wget bash'

    echo "Installing… Bats (Bash Automated Testing System)"
    echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

    BATS_VERSION=$(set_version_to_use)
    echo "The provided Bats version is: $BATS_VERSION"

    install_bats "$BATS_VERSION"
    add_bats_to_PATH
}

run