#!/usr/bin/env -S just --justfile

set shell := ["fish", "-c"]

default_image:="base"
# default tag for test recipe (ubuntu,debian,alpine)
default_tag:="debian"

default:
    @just --list

# run global test
global:
    devcontainer features test --global-scenarios-only .

# run tests on the given feature
test feature image=default_image tag=default_tag: cleanup
    devcontainer features test \
        --features {{feature}} \
        --skip-scenarios \
        --base-image mcr.microsoft.com/devcontainers/{{image}}:{{tag}} .

# run test scenarios on the given feature
scenarios feature:
    devcontainer features test \
        --features {{feature}} \
        --skip-autogenerated .

cleanup:
    -docker rm -f $(docker ps -a -q)
    -docker image rm -f $(docker image ls -q)

install-requirements:
    npm install -g @devcontainers/cli
    fish -c 'fisher install pure-fish/pure'

all_features:='*'
test-installing feature=all_features: install-dev-requirements
    ./.bin/bats-core/bin/bats ./src/{{feature}}/install.test.bats

install-dev-requirements:
    if test ! -d .bin/bats-core; git clone --depth 1 https://github.com/bats-core/bats-core.git .bin/bats-core; end 
    if test ! -d .bin/test_helper/bats-support; git clone --depth 1 https://github.com/bats-core/bats-support.git .bin/test_helper/bats-support; end 
    if test ! -d .bin/test_helper/bats-assert; git clone --depth 1 https://github.com/bats-core/bats-assert.git .bin/test_helper/bats-assert; end 

