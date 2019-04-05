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

PACKAGE=${PACKAGE:-"math-functions"}
# TODO je to dobry zpusob predavat data o tom, jake rpm testujeme?
RPM_PATH=${RPM_PATH:-}

rlJournalStart
    rlPhaseStartSetup
        # This section installs package under test if it's not already
        # installed and performs general enviromental setup
        # Tato sekce instaluje balicek, ktery chceme testovat (pokud jeste
        # nainstalovany neni) a obecne nastavuje system
        rlAssertRpm $PACKAGE || rlRun "rpm -ivh $RPM_PATH" 0 \
            "Install tested rpm $RPM_PATH"
        # Check that factorial command belongs to math-functions package
        # TODO: fix specfile so it installs packages in /usr/bin,
        # not /home/jheger
        export PATH=/home/jheger/bin:$PATH
        rlAssertBinaryOrigin factorial math-functions
        rlRun "TmpDir=\$(mktemp -d)" 0 "Creating tmp directory"
        rlRun "pushd $TmpDir"
    rlPhaseEnd

    rlPhaseStartTest "No arguments"
        # This section checks if running 'factorial' with no arguments works
        # Tato sekce testuje to, jak funguje zpusteni prikazu 'factorial' s
        # zadnymi argumenty
        rlRun "factorial 2>&1 | tee log" 0 "Run factorial with no parameters"
        rlAssertGrep "Usage: factorial NUMBER" "log"
    rlPhaseEnd

    rlPhaseStartTest "Help"
        # This section checks if running 'factorial --help' works
        # Tato sekce testuje to, jak funguje napoveda ('factorial --help')
        rlRun "factorial --help 2>&1 | tee log" 0 "Run factorial with no parameters"
        rlAssertGrep "Usage: factorial NUMBER" "log"
    rlPhaseEnd

    rlPhaseStartTest "Positive numbers"
        rlRun "factorial 1 2>&1 | tee log" 0 "Run factorial on number 1"
        rlAssertGrep "1" "log"
        rlRun "factorial 2 2>&1 | tee log" 0 "Run factorial on number 2"
        rlAssertGrep "2" "log"
        rlRun "factorial 5 2>&1 | tee log" 0 "Run factorial on number 5"
        rlAssertGrep "120" "log"
        rlRun "factorial 10 2>&1 | tee log" 0 "Run factorial on number 10"
        rlAssertGrep "3628800" "log"
    rlPhaseEnd

    rlPhaseStartTest "Negative numbers"
        #TODO: Zaporna cisla nefunfujou :(
        rlRun "factorial -1 2>&1 | tee log" 0 "Run factorial on number -1"
        rlAssertGrep "-1" "log"
        rlRun "factorial -2 2>&1 | tee log" 0 "Run factorial on number -2"
        rlAssertGrep "-2" "log"
        rlRun "factorial 5 2>&1 | tee log" 0 "Run factorial on number -5"
        rlAssertGrep "-120" "log"
        rlRun "factorial 10 2>&1 | tee log" 0 "Run factorial on number -10"
        rlAssertGrep "-3628800" "log"
    rlPhaseEnd

    rlPhaseStartTest "Zero"
        #TODO: faktorial nuly je skutecne 1, ale toto pada na new
        rlRun "factorial 0 2>&1 | tee log" 0 "Run factorial on number 0"
        rlAssertGrep "1" "log"
    rlPhaseEnd

    rlPhaseStartTest "Non-numbers"
        #TODO: "Exiting unsuccessfully", ale vraci 0?
        rlRun "factorial foo 2>&1 | tee log" 0 \
            "Run factorial with non-numeric arguments"
        rlAssertGrep "Argument doesn't seem to be an integer." "log"
    rlPhaseEnd

    rlPhaseStartCleanup
        rlRun "popd"
        rlRun "rm -r $TmpDir" 0 "Removing tmp directory"
    rlPhaseEnd
rlJournalPrintText
rlJournalEnd
