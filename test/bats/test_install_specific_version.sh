#!/usr/bin/env bash
set -e
source dev-container-features-test-lib # Optional: Import test library bundled with the devcontainer CLI


check "is executable" test -x $HOME/bin/bats
echo $VERSION
env
check "version" bats --version | grep $VERSION

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults