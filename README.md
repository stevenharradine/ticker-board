# Bash-Test-Suite
A framework for running tests on your BASH applications

## Usage
To use this framework, copy or pull this repo into your applications repo.  It will create some files for you:

### .github/workflows/my-bash-tests.yml
This file invokes these tests in github for you

### tests/example-cat.sh and tests/example-echo.sh
These are tests to show the testing framework is working, you can delete them from your application.

### tests/test-template.sh
This is a basic template you can start with for creating your own tests

### run-tests.sh
This script actually runs all your tests in the test folder
