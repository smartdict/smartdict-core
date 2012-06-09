Feature: version command

    In order to see information about the program
    As a user
    I want to use "smartdict --version" command

    Scenario Outline: see help message
        When I run `<command>`
        Then the output should match /Smartdict \d{1,2}\.\d{1,2}\.\d{1,2}/
        Then the output should contain "Author: Sergey Potapov"
        Then the output should contain "URL: http://smartdict.net"

        Scenarios: see help message
            |command            |
            |smartdict -v       |
            |smartdict --version|
            |smartdict version  |
