#!/usr/bin/env bash
set -e

function ensure() {
    package="$1"

    source /etc/os-release
    distroId="$ID"
    echo "Ensure $package is installed on $distroId"

    case "$distroId" in
        alpine)
            apk add \
                    --no-cache \
                "$package"
        ;;
        ubuntu|debian)
            apt-get update
            apt-get install \
                    --yes \
                    --no-install-recommends \
                "$package"
            rm -rf /var/lib/apt/lists/* # clean up
        ;;
        centos)
            dnf update
            dnf install \
                    --yes \
                "$package"
        ;;
        *)
            echo "Unsupported distribution"
            exit 1
        ;;
    esac
    command curl -V
}


function install() {
    ensure 'curl'

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