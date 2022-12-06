#!/usr/bin/env sh
set -e
install() {
    . ../ensure.sh && ensure 'git wget bash'

    printf "Installing… 'pacapt' (cross-os package managers)"

    ROOT_USER_ID=0
    if [ "$(id -u)" -eq $ROOT_USER_ID ]; then
        printf "using root\n"
        wget -q -O /usr/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
        chmod 755 /usr/bin/pacapt
    else
        printf "using user\n"
        sudo wget -q -O /usr/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
        sudo chmod 755 /usr/bin/pacapt
    fi

    pacapt -V | head -n 1
}