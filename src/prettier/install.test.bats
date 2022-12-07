setup() {
    load '../../.bin/test_helper/bats-support/load'
    load '../../.bin/test_helper/bats-assert/load'

    # get the containing directory of this file
    FEATURE_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$FEATURE_DIR:$PATH" # add feature to PATH
}
FEATURE="prettier"

@test "can run our script" {
    curl() { exit $SUCCESS; }; export -f curl; #mock
    run install.sh
    
    assert_output --partial "Installing… Prettier"
}

@test "can ensure required package are present" {
    run install.sh
    
    assert_output --partial "Ensure availability of"
    assert_output --partial "Ensure… done"

    run type curl
    assert_success

    curl() { exit $SUCCESS; }; export -f curl; #mock
    run type bash
    assert_success
}

@test "can access environment variable `VERSION`" {
    curl() { exit $SUCCESS; }; export -f curl; #mock
    run install.sh
    
    assert_output --partial "version is: latest"
}

check_feature_help() {
    $FEATURE --help | head -n 1
}
@test "can use CLI" {
    run check_feature_help

    assert_success
    assert_output --partial $FEATURE
}
