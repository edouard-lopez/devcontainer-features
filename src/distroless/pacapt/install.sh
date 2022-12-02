#!/usr/bin/env bash
set -e

function install() {
    printf "Installing… 'pacapt' (cross-os package managers)"

    ROOT_USER_ID=0
    if [ "$(id -u)" -eq $ROOT_USER_ID ]; then
        printf "using root\n"
        curl -L -s -o /usr/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
        chmod 755 /usr/bin/pacapt
    else
        printf "using user\n"
        sudo curl -L -s -o /usr/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
        sudo chmod 755 /usr/bin/pacapt
    fi

    pacapt -V | head -n 1
}