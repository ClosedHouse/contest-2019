from behave import *
import subprocess
import shlex
import sys

# trida 
class CommandResult(object):
    """
    Trida reprezentuje vystupy spusteneho prikazu
    Class represents the outputs of the executed command
    """

    def __init__(self, command, exitcode, stdout, stderr):
        self.command = command
        self.exitcode = exitcode
        self.stdout = stdout
        self.stderr = stderr


class Command(object):
    """
    Trida obsluhuje spousteni prikazu a vraceni vystupu prostrednictvim objektu CommandResult
    Class handles arbitrary command execution and returns the output using the CommandResult object
    """

    @classmethod
    def run(self, command):
        # oddelim jednotlive argumenty / parse individual arguments from the command line
        real_command = shlex.split(command)
        # pro snazsi debugging vypisi spousteny prikaz na stdout i stderr 
        # to ease debugging write executed command both to stdout and stderr
        #sys.stdout.write("Running: %s\n" % command)
        #sys.stderr.write("Running: %s\n" % command)
        process = subprocess.Popen(real_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        stdout, stderr = process.communicate()
        # pro snazsi debugging predam vystupy do terminalu
        # to ease debugging forward the outputs to the terminal
        #sys.stdout.write(stdout)
        #sys.stderr.write(stderr)
        return CommandResult(real_command, process.returncode, stdout, stderr)
        

@given('I install package "{name}"')
def given_I_install_package(context, name):
    """
    test step instalujici dany balicek
    test step installing given package
    """
    context.command = Command.run("dnf -y install " + name)
    assert context.command.exitcode is 0

@then('package "{name}" is installed')
def then_package_is_installed(context, name):
    """
    test step overujici ze dany balicek je nainstaloval
    test step to verify that a given package is installed
    """
    context.command = Command.run("rpm -q " + name)
    assert context.command.exitcode is 0

@step('I run command "{command}"')
def step_I_run_command(context, command):
    """
    test step spoustici libovolny prikaz
    test step to run arbitrary command
    """
    context.command = Command.run(command)

@step('command exit code is "{exitcode}"')
def step_command_exit_code_is(context, exitcode):
    """
    test step kontrolujici exit kod posledne spusteneho prikazu
    test step to verify exit code of the previously run command
    """
    assert context.command.exitcode == int(exitcode)

@then('command stdout contains string "{text}"')
def then_command_stdout_contains_string(context, text):
    """
    test step hledajici text v standardnim vystupu posledne spusteneho prikazu
    test step searches for a given text in the standard output of the previously run command
    """
    assert text in context.command.stdout

