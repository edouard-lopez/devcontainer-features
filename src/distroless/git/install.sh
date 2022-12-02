#!/usr/bin/env bash
set -e

function install() {
    distro=$(lsb_release --id --short)
    echo "Installing… 'git' for… $distro"

    sudo pacapt install git
}