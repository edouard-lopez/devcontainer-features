setup() {
    load '../../../.bin/test_helper/bats-support/load'
    load '../../../.bin/test_helper/bats-assert/load'

    # get the containing directory of this file
    FEATURE_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$FEATURE_DIR:$PATH" # add feature to PATH

    source install.sh
}

@test "can detect distribution Id" {
    SUCCESS=0
    pacapt() { exit $SUCCESS; }; export -f pacapt # mock


    run install
    
    assert_output --regexp  "Installing… '[a-z]+' for… [A-Z][a-z]+"
    assert_success
}

@test "can print git version" {
    run install
    
    assert_success

    run git --version
    assert_success
    assert_output --regexp  "git version .+"
}
