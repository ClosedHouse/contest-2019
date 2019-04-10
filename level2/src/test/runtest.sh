#!/bin/bash
# vim: dict+=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   runtest.sh of /CoreOS/tests/Sanity/factorial
#   Description: Basic sanity tests for factorial package
#   Author: Anna Khaitovich <akhaitov@redhat.com>
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Include Beaker environment
. /usr/bin/rhts-environment.sh || exit 1
. /usr/share/beakerlib/beakerlib.sh || exit 1

rlJournalStart
    rlPhaseStartSetup
        # This section performs general enviromental setup
        #
        # Tato sekce obecne nastavuje system
        rlRun "TmpDir=\$(mktemp -d)" 0 "Creating tmp directory"
        rlRun "pushd $TmpDir"
    rlPhaseEnd

    rlPhaseStartTest "Factorial"
        # This section tests factorial package.
        # There are 7 assertions - commands, that execute specific actions and compare
        # the result of it with the expected one.
        #
        # Tato sekce testuje balicek factorial.
        # Tady se pouziva 7 assertions - prikazu, ktere vykonavaji nejaky cin a
        # porovnavaji jeho vysledek s vysledkem, ktery ocekavame.
        rlRun "factorial 2>&1 | grep \"No argument given!\"" 0 "Run factorial with no parameters"
        rlRun "factorial --help | grep \"Usage: factorial INTEGER\"" 0 "Run factorial --help"
        rlAssertEquals "Calculate !1" $(factorial 1) 1 
        rlAssertEquals "Calculate !5" $(factorial 5) 120
        rlAssertEquals "Calculate !0" $(factorial 0) 1
        rlRun "factorial -1 2>&1 | grep \"<not_defined>\"" 0 "Run factorial on negative number"
        rlRun "factorial foo 2>&1 | grep \"Argument doesn't seem to be an integer.\"" 10 \
            "Run factorial with non-numeric arguments"
    rlPhaseEnd

    rlPhaseStartCleanup
        # This section cleans up the environment
        #
        # Tato sekce uklidi prostredi
        rlRun "popd"
        rlRun "rm -r $TmpDir" 0 "Removing tmp directory"
    rlPhaseEnd
rlJournalPrintText
rlJournalEnd
