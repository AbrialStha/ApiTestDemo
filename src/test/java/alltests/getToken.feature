@ignore
Feature: To sign-in to the App and get token once

  Scenario:
    * url baseUrl
    * def credentials = {username:'#(username)', password:'#(password)'}

    Given path '/api/login'
    And header Accept = '*/*'
    And header Content-Type = 'application/json'
    And  request credentials
    When method post
    Then status 200
    And def token = 'beareer' + ' ' + response.token