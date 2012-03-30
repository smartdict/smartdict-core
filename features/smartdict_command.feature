Feature: smartdict

    In order to start using smartdict
    As a user
    I want to use "smartdict" command

    Scenario Outline: see help message
        When I run `<command>`
        Then the output should contain "Smartdict is a dictionary"
        And the output should contain "Syntax:"
        And the output should contain "smartdict COMMAND [arguments...] [options...]"
        And the output should contain "smartdict help COMMAND"
        And the output should contain "Commands:"
        And the output should contain "help         Show help message"
        And the output should contain "translate    Translate a word"

        Scenarios: see help message
            |command         |
            |smartdict       |
            |smartdict -h    |
            |smartdict --help|
