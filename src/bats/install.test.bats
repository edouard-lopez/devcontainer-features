setup() {
    load '../../.bin/test_helper/bats-support/load'
    load '../../.bin/test_helper/bats-assert/load'

    # get the containing directory of this file
    FEATURE_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$FEATURE_DIR:$PATH" # add feature to PATH
}

@test "can run our script" {
    git() { echo "git $*"; exit; }; export -f git # mock

    run install.sh
    
    assert_output --partial "Installing… Bats"
}

@test "can ensure package are present" {
    apk() { echo; }; export -f apk # mock
    apt() { echo; }; export -f apt # mock
    dnf() { echo; }; export -f dnf # mock

    run install.sh
    
    assert_output --partial "Ensure availability of"
    assert_output --partial "Ensure… done"

}

@test "can access environment variable `VERSION`" {
    git() { echo "git $*"; exit; }; export -f git # mock
    export VERSION="v1.0.0"

    run install.sh
    
    assert_output --partial "Bats version is: ${VERSION}"
}

@test "can convert latest to master" {
    git() { echo "git $*"; exit; }; export -f git # mock
    export VERSION="latest"

    run install.sh
    
    assert_output --partial "Bats version is: master"
}

@test "can convert specific version" {
    git() { echo "git $*"; exit; }; export -f git # mock
    export VERSION="v1.2.0"

    run install.sh
    
    assert_output --partial "Bats version is: $VERSION"
}

@test "can install bats-core" {
    export VERSION="v1.2.0"
    export _REMOTE_USER_HOME=$HOME
    run install.sh
    
    assert_output --partial "Cloning bats-core"
    assert [ -d $HOME/bats-core ]
    assert_success

    run $HOME/bin/bats --version
    assert_output 'Bats 1.2.0'
}

@test "can find PATH config to resolve to bats executable" {
    run grep --only-matching '$HOME/bin' $HOME/.profile

    assert_output --partial '$HOME/bin'
}

teardown_file() {
    rm -rf \
        $HOME/bats-core \
        $HOME/bin/bats
}