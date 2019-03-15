# toto je zakladni test pro overeni funkcnosti prikazu file
# prikaz file slouzi k identifikaci typu souboru predanych jako argumenty
# napr: 'file /etc/passwd' ci 'file /bin/bash'
# vyzkousejte si prikaz v terminalu, prohlednete si man stranku 'man file'
#
# this is a basic test to verify the functionality of the file command
# file commands identifies the type of the files provided as arguments
# e.g. 'file /etc/passwd' or 'file /bin/bash'
# try to run the examples from the terminal, see the man page 'man file'

Feature: Basic file command test

	@setup
	Scenario: Ensure the tested package is installed
		Given I install package "file"
		 Then package "file" is installed

	Scenario: file -v prints the program version
		 When I run command "file -v"
		 Then command exit code is "0"
		  And command stdout contains string "file-5."
		  And command stdout contains string "magic file from /etc/magic:/usr/share/misc/magic"

	Scenario: file can identify text file
		When I run command "file /etc/passwd"
		Then command exit code is "0"
		 And command stdout contains string "/etc/passwd: ASCII text"
