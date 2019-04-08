# ROZPRACOVANO - z nejakeho duvodu test nefunguje, dovedes jej opravit?
# toto je zakladni test pro overeni funkcnosti prikazu grep
# prikaz grep hleda v souboru zadany text
# napr: 'grep root /etc/passwd'
#
# WORK IN PROGRESS - for some reason the test is failing. Can you fix it?
# this is a basic test to verify the functionality of the grep command
# grep command searches for a given text inside the text file
# e.g. 'grep root /etc/passwd'

Feature: Basic grep command test

	@setup
	Scenario: Ensure the tested package is installed
		Given I install package "grep"
		 Then package "grep" is installed

	Scenario: I can search text in a text file
		When I run command "grep root /etc/passwd"
		Then command exit code is "0"
		 And command stdout contains string "root:x:0:0:root:/root:/bin/bash"

	Scenario: grep -h command prints the usage help
		 When I run command "grep -h"
		 Then command exit code is "2"
		  And command stdout contains string "Usage: grep"

