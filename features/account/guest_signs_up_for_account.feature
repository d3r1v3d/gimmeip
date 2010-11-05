Feature: guest signs up for account
    So that I can sign up for an account
    As a guest
    I need to go through the registration process

Scenario: Sign up for an account successfully
    Given I am on the sign up page
    When I fill in "user_name" with "whee"
    And I fill in "user_email" with "whee@completelyfake.com"
    And I fill in "user_password" with "test1234"
    And I fill in "user_password_confirmation" with "test1234"
    And I press "user_submit"
    Then I should see "You have successfully signed up."
