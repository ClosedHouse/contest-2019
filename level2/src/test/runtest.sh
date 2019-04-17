#!/bin/bash
# vim: dict+=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   Description: Basic sanity tests for factorial package
#   Author: Anna Khaitovich <akhaitov@redhat.com>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set -o pipefail

# Source beakerlib test framework
. /usr/share/beakerlib/beakerlib.sh || exit 1

rlJournalStart
    # This phase performs general testing enviromental setup. You can ignore it.
    #
    # Tato faze nastavuje obecne testovaci prostredi. Muzete ji ignorovat.
    rlPhaseStartSetup
        rlRun "TmpDir=\$(mktemp -d)" 0 "Creating tmp directory"
        rlRun "pushd $TmpDir"
    rlPhaseEnd

    # This phase tests basic sanity of package.
    # There is one failing test case in this phase: factorial is called with non-integer
    # input which is obviously not valid. This issue is already solved in provided
    # package with version 1.1.1. Simply install it and this phase should pass.
    # rlRun function runs command given as first argument. It FAILs if returned
    # value from the command is not equal to the second argument passed to rlRun.
    # Third argument is just string printed in test log.
    #
    # Tato faze testuje zakladni funkcnost balicku.
    # Ve fazi je jeden failujici test case: factorial se vola s necelociselnym
    # argumentem coz neni validni. Tento problem je vyresen v poskytnutem balicku
    # s verzi 1.1.1. Staci ho nainstalovat a tato faze by mela projit.
    # rlRun funkce spusti prikaz dany prvnim argumentem. Funkce vrati FAIL pokud
    # se navratova hodnota spusteneho prikazu nerovna druhemu argumentu funkce rlRun.
    # Treti argument je jen retezec ktery se napise do test logu.
    rlPhaseStartTest "Sanity"
        rlRun "factorial --help | grep \"Usage: factorial INTEGER\"" 0 "Run factorial --help"
        rlRun "factorial 2>&1 | grep \"No argument given!\"" 1 "Run factorial with no parameters"
        rlRun "factorial foo 2>&1 | grep \"Argument does not seem to be an integer.\"" 10 \
            "Run factorial with non-numeric arguments"
    rlPhaseEnd

    # This phase tests common, expected input.
    # However QE engineer who wrote this test made a typo and mistakenly expect
    # wrong value to be returned from factorial. Find the typo and fix it.
    # rlAssertEquals function compares two values, given as second and third
    # argument (first one is just string for test log). Assert FAILs when
    # second and third arguments are not equal.
    #
    # Tato faze testuje bezny, ocekavany vstup.
    # Nicmene QA inzenyrka ktera napsala tento test udelala preklep a ted ocekava
    # ze factorial vrati spatnou hodnotu. Najdete ten preklep a opravte ho.
    # rlAssert funkce porovnava dve hodnoty ktere jsou funkci predany pres druhy
    # a treti argument (prvni je jen retezec to test logu). Assert vrati FAIL
    # pokud si druhy a treti argument nejsou rovny.
    rlPhaseStartTest "Common values"
        rlAssertEquals "Calculate 3!" $(factorial 3) 6
        rlAssertEquals "Calculate 5!" $(factorial 5) 121
        rlAssertEquals "Calculate 10!" $(factorial 10) 3628800
    rlPhaseEnd

    # This phase tests edge cases.
    # Developer who wrote the factorial was a bit lazy and didn't cover edge cases
    # in his implementation. Program doesn't behave correctly for input 0 and for
    # negative integers. It is up to you to fix the program, build new version of
    # the package and install it. If you do it correctly, this phase will pass.
    # rlRun and rlAssertEquals functions are described in first and second phase comments.
    #
    # Tato faze testuje edge casy (okrajove hodnoty).
    # Developer, ktery napsal factorial byl trochu liny a nepokryl edge casy ve
    # sve implementaci. Program se nechova spravne pro vstup 0 a negativni cela
    # cisla. Je na vas abyste opravili chovani programu, vybuildili novou verzi
    # balicku a nainstalovali ji. Pokud to udelate spravne, faze projde.
    # rlRun a rlAssertEquals funkce jsou popsane v komentarich prvni a druhe faze.
    rlPhaseStartTest "Edge cases"
        rlAssertEquals "Calculate 1!" $(factorial 1) 1
        rlAssertEquals "Calculate 0!" $(factorial 0) 1
        rlRun "factorial -1" 1-255 "Factorial is not defined for negative integers"
    rlPhaseEnd

    # This phase cleans up the testing environment. You can ignore it.
    #
    # Tato faze uklidi testovaci prostredi. Muzete ji ignorovat.
    rlPhaseStartCleanup
        rlRun "popd"
        rlRun "rm -r $TmpDir" 0 "Removing tmp directory"
    rlPhaseEnd
rlJournalEnd
