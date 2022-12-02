setup() {
    load '../../.bin/test_helper/bats-support/load'
    load '../../.bin/test_helper/bats-assert/load'


    # get the containing directory of this file
    FEATURE_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$FEATURE_DIR:$PATH" # add feature to PATH
}

@test "can run 'git' install script" {
    run install.sh
    
    assert_output --partial "Installing… 'git'"
}

@test "can run 'pacapt' install script" {
    run install.sh
    
    assert_output --partial "Installing… 'pacapt'"
}
