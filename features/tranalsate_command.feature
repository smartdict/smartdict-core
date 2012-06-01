# TODO: do not do remote requests
#
Feature: smartdict translate

    In order to translate a word
    As a user
    I want to use "smartdict translate" command

    Scenario: translate a word
        When I run `smartdict translate hello --from en --to de`
        Then the output should contain "hello"
        Then the output should contain "Hallo"
