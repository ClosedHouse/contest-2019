#!/bin/bash
# vim: dict+=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   runtest.sh of /CoreOS/tests/Sanity/factorial
#   Description: Basic sanity tests for factorial package
#   Author: Anna Khaitovich <akhaitov@redhat.com>
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set -o pipefail

# Include Beaker environment
. /usr/bin/rhts-environment.sh || exit 1
. /usr/share/beakerlib/beakerlib.sh || exit 1

rlJournalStart
    rlPhaseStartSetup
        # This phase performs general testing enviromental setup
        #
        # Tato faze nastavuje obecne testovaci prostredi
        rlRun "TmpDir=\$(mktemp -d)" 0 "Creating tmp directory"
        rlRun "pushd $TmpDir"
    rlPhaseEnd

    # TODO rewrite this text, put into individual phases
    # This section tests factorial package.
    # There are 7 assertions - commands, that execute specific actions and compare
    # the result of it with the expected one.
    #
    # Tato sekce testuje balicek factorial.
    # Tady se pouziva 7 assertions - prikazu, ktere vykonavaji nejaky cin a
    # porovnavaji jeho vysledek s vysledkem, ktery ocekavame.
    # hint: one of next 3 assertions has wrong expected result
    # napoveda: jedna s nasledujicich 3 assertions ma spatny ocekavany vysledek

    rlPhaseStartTest "Sanity"
        rlRun "factorial 2>&1 | grep \"No argument given!\"" 1 "Run factorial with no parameters"
        rlRun "factorial --help | grep \"Usage: factorial INTEGER\"" 0 "Run factorial --help"
        rlRun "factorial foo 2>&1 | grep \"Argument does not seem to be an integer.\"" 10 \
            "Run factorial with non-numeric arguments"
    rlPhaseEnd

    rlPhaseStartTest "Common values"
        rlAssertEquals "Calculate 3!" $(factorial 3) 6
        rlAssertEquals "Calculate 5!" $(factorial 5) 121
        rlAssertEquals "Calculate 10!" $(factorial 10) 3628800
    rlPhaseEnd

    rlPhaseStartTest "Edge cases"
        rlAssertEquals "Calculate 1!" $(factorial 1) 1
        rlAssertEquals "Calculate 0!" $(factorial 0) 1
        rlRun "factorial -1" 1-255 "Factorial is not defined for negative integers"
    rlPhaseEnd

    rlPhaseStartCleanup
        # This phase cleans up the testing environment
        #
        # Tato faze uklidi testovaci prostredi
        rlRun "popd"
        rlRun "rm -r $TmpDir" 0 "Removing tmp directory"
    rlPhaseEnd
rlJournalEnd
