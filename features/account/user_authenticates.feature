Feature: user authenticates
    So that I can leverage my user account's site-specific permissions
    As a registered user
    I need to be able to log in and log out

Background:
    Given a user exists with the following attributes:
        | Name                  | minimal           |
        | Email                 | minimal@user.com  |
        | Password              | test1234          |
        | Password Confirmation | test1234          |

Scenario Outline: Attempt to log in
    Given I am on the sign in page
    When I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I press "user_submit"
    Then I should <action>
    Examples:
        |   email           |   password    |   action                          |
        | minimal@user.com  | test1234      | see "Signed in successfully."     |
        | whee@fakey.org    | blah          | see "Invalid email or password."  |
        |                   | blah          | see "Invalid email or password."  |
        | whee@fakey.org    |               | see "Invalid email or password."  |

Scenario: Log out
    Given I am logged in as "minimal"
    When I go to the sign out link
    Then I should see "Signed out successfully."
