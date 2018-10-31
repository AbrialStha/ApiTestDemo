Feature: User Related Api Test

  Background:
    * url baseUrl
    * def signIn = callonce read('../getToken.feature') {username: "peter@klaven", password: "cityslicka"}
    * def token = signIn.token
    * print '>> token :: ', token

  @ListALlUsers
  Scenario: List all the registered users
    Given path '/api/users'
    And header authorization = token
    When method get
    Then status 200
    * def resp = response
    * def data = resp.data
    * print '>> The Response is:: ', resp
    And match resp ==
      """
      {
        "page": '#number',
        "per_page": '#number',
        "total": '#number',
        "total_pages": '#number',
        "data": '#array'
      }
      """
    And match each data ==
      """
      {
        "id": '#number',
        "first_name": '#string',
        "last_name": '#string',
        "avatar": '#string'
      }
      """

  @ListALlUsersWithPageQuery
  Scenario: List all the registered users with page query
    Given path '/api/users'
    * def pagenumber = 2
    And params {page: '#(pagenumber)'}
    And header authorization = token
    When method get
    Then status 200
    * def resp = response
    * def data = resp.data
    * print '>> The Response is:: ', resp
    And match resp ==
      """
      {
        "page": '#(pagenumber)',
        "per_page": '#number',
        "total": '#number',
        "total_pages": '#number',
        "data": '#array'
      }
      """
    And match each data ==
      """
      {
        "id": '#number',
        "first_name": '#string',
        "last_name": '#string',
        "avatar": '#string'
      }
      """

  @ListSingleUser
  Scenario: List single user Data
    * def userId = 2
    Given path '/api/users', userId
    And header authorization = token
    When method get
    Then status 200
    * def resp = response.data
    * print '>> The Response is:: ', resp
    And match resp ==
    """
      {
        "id": '#(userId)',
        "first_name": '#string',
        "last_name": '#string',
        "avatar": '#string'
      }
    """