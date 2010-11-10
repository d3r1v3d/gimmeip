Feature: user modifies account
    So that I can keep my account information up-to-date
    As a registered user
    I need to be able to modify aspects of my account information

Background:
    Given a user exists with the following attributes:
        | Name                  | Eli Manning   |
        | Email                 | eli@nfl.com   |
        | Password              | peytonsucks   |
        | Password Confirmation | peytonsucks   |
    Given a user exists with the following attributes:
        | Name                  | Peyton Manning        |
        | Email                 | laser@rocketarm.com   |
        | Password              | imawesome             |
        | Password Confirmation | imawesome             |

Scenario Outline: Change account information
    Given I am logged in as "Eli Manning"
    And I am on the edit account page
    When I fill in "user_name" with "<name>"
    And I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I fill in "user_password_confirmation" with "<password>"
    And I fill in "user_current_password" with "<current_password>"
    And I press "user_submit"
    Then I should <action>
    Examples:
        | name                  | email                 | password      | current_password  | action                                        |
        | Peyton Manning        | eli@nfl.com           |               | peytonsucks       | see "has already been taken"                  |
        |                       | laser@rocketarm.com   |               | peytonsucks       | see "has already been taken"                  |
        | Eli The 'Man'ning     | eli@nfl.com           |               |                   | see "can't be blank"                          |
        | Eli The 'Man'ning     | eli@nfl.com           |               | peytonsucks       | see "You updated your account successfully."  |
