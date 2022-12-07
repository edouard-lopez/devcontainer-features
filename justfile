#!/usr/bin/env -S just --justfile

set shell := ["bash", "-uc"]

default:
    @just --list

# run global test
test-global-scenarios-only:
    devcontainer features test --global-scenarios-only .

# run tests on the given feature
default_image:="alpine:latest"
test feature image=default_image: cleanup
    devcontainer features test \
        --features {{feature}} \
        --skip-scenarios \
        --base-image {{image}} .

test-with-scenarios feature image=default_image: cleanup
    devcontainer features test \
        --features {{feature}} \
        --base-image {{image}} .

all_features:='*'
test-installing feature=all_features: install-dev-requirements
    shopt -s globstar \
    && ./.bin/bats-core/bin/bats ./src/{{feature}}/**/*.bats

# run test scenarios on the given feature
test-scenarios feature:
    devcontainer features test \
        --features {{feature}} \
        --skip-autogenerated .

install-extra:
    fish -c 'fisher install pure-fish/pure'

install-dev-requirements:
    @type devcontainer >/dev/null 2>&1 \
    || npm install -g @devcontainers/cli
    @[[ ! -d .bin/ ]] && mkdir -p .bin/ || true
    @[[ ! -d .bin/bats-core ]] && git clone --depth 1 https://github.com/bats-core/bats-core.git .bin/bats-core || true
    @[[ ! -d .bin/test_helper/bats-support ]] && git clone --depth 1 https://github.com/bats-core/bats-support.git .bin/test_helper/bats-support || true
    @[[ ! -d .bin/test_helper/bats-assert ]] && git clone --depth 1 https://github.com/bats-core/bats-assert.git .bin/test_helper/bats-assert || true

cleanup:
    -docker rm -f $(docker ps -a -q)
    -docker image rm -f $(docker image ls -q)
