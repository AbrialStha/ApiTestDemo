Feature: karate answers 2

  Background:
    * url baseUrl

  @ListSingleUsers(table)
  Scenario Outline: List single users Data

    Given path '/api/users', <userId>
    And header authorization = token
    When method get
    Then status 200
    * def resp = response.data
    * print '>> The Response is:: ', resp
#   Check Data from here
    * def dataGenerator = function(data){ return {id: data.id, first_name: data.first_name, last_name: data.last_name, avatar:data.avatar} }
    * def Data = call dataGenerator { id: <userId>, first_name: <first_name>, last_name: <last_name>, avatar: <avatar> }
    * print ">> the val:: ", Data
    And match resp ==
    """
      {
        "id": <userId>,
        "first_name": <first_name>,
        "last_name": <last_name>,
        "avatar": <avatar>
      }
    """
    And match resp == Data

    Examples:
      | userId | first_name | last_name | avatar                                                              |
      | 1      | George     | Bluth     | https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg   |
      | 2      | Janet      | Weaver    | https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg  |
      | 3      | Emma       | Wong      | https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg |
