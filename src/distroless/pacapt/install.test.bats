    setup() {
        load '../../../.bin/test_helper/bats-support/load'
        load '../../../.bin/test_helper/bats-assert/load'

        # get the containing directory of this file
        FEATURE_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
        PATH="$FEATURE_DIR:$PATH" # add feature to PATH

        source install.sh
        sudo rm -rf /usr/bin/pacapt
    }

    @test "can ensure 'curl' is present" {
        curl() { exit 0; }; export -f curl # mock

        run install

        assert_output --partial 'Ensure curl'
        assert_success
        assert_output --regexp 'curl [0-9].+'
    }

    @test "can install with root user" {
        ROOT_USER_ID=0
        ensure() { echo; }; export -f ensure # mock
        id() { echo $ROOT_USER_ID; }; export -f id # mock
        curl() { exit 0; }; export -f curl # mock

        run install
        
        assert_output --partial "Installing… 'pacapt'"
        assert_output --partial 'using root'
        assert_success
    }

    @test "can install with standard user" {
        STANDARD_USER_ID=1000
        ensure() { echo; }; export -f ensure # mock
        id() { echo $STANDARD_USER_ID; }; export -f id # mock

        run install
        
        assert_output --partial "Installing… 'pacapt'"
        assert_output --partial 'using user'
        assert [ -x /usr/bin/pacapt ]
        assert_output --partial "pacapt version"
    }

