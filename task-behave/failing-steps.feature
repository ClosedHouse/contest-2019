# just for testing purposes, all scenarios are expected to fail
# we have it to verify integrity of individual steps, checking that
# they were not modified to always pass

Feature: Failing test scenarios

	@setup
	Scenario: test fail of I install package
		Given I install package "no_such_package"

	Scenario: test fail of package is installed
		Then package "no_such_package" is installed

	Scenario: test fail of I run command
		 When I run command "/usr/bin/no_such_command"

	Scenario: test fail of command exit code is
		 When I run command "grep -h"
		 Then command exit code is "99"

	Scenario: test fail of command stdout contains string
		 When I run command "grep -h"
		 Then command stdout contains string "no_such_string"

	Scenario: test fail command stderr contains string
		 When I run command "grep -h"
		 Then command stdout contains string "no_such_string"
