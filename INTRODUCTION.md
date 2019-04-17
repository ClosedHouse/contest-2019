## Introduction

We are **BaseOS QE** team, which takes care of RHEL's (Red Hat Enterprise Linux) quality as it's main responsibility. So, we test RHEL, but that doesn't mean we just randomly push buttons in the GUI :) We use various tools for testing (Bash, Python and testing frameworks written in those languages, automation, static code analyzers, etc.), we work in terminal most of the time, automate a lot and have to deal with a huge range of technology.

In this game you have a chance to try some of those. You'll look for security exploits, write tests in Python testing framework - Behave, and look for errors in an RPM package with internal testing framework BeakerLib.

The game is composed of 3 levels. In each level you have to get a secret code that should match pattern **OH19\_[A-Z1-9]** (aka it is prefixed by OH19_). As soon as you get the secret code, level is considered done and you may get a gift :)

In your home directory **/home/oh** you will find **level1/**, **level2/** and **task-behave/** directories:

```
$ cd /home/oh
$ ll
drwxrwxr-x. 2 oh oh 4.0K Apr 17 08:29 level1
drwxrwxr-x. 4 oh oh 4.0K Apr 17 08:29 level2
drwxrwxr-x. 2 oh oh 4.0K Apr 17 08:29 task-behave
```

Each of these directories contains a task (level), including README file. It's recomended to start with reading this file.
