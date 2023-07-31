Feature: Testing Petstore


  Scenario: As a user, I would like to search for available pets
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus'
    And params { "status": "available"}
    When method get
    Then status 200
    And def availableStatus = "available"
    And match each response[*].status == availableStatus


  Scenario Outline: As a user, I would like to find pets by status
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus'
    And params { "status": "<status>"}
    When method get
    Then status 200
    And def availableStatus = "available"
    And match each response[*].status contains '<status>'

    Examples:
    |status|
    |available|
    |pending|
    |sold   |

  Scenario: As a user, I would like to add a new cat
    Given url 'https://petstore.swagger.io/v2/pet'
    And request
    """
    { "id": 12345,
  "category": {
  "id": 1,
  "name": "cats"
  },
  "name": "Chonky Boy",
  "photoUrls": [
  "https://www.cats.com/ChonkyBoy.jpg"
  ],
  "tags": [
  {
  "id": 1,
  "name": "Fuzzy"
  }
  ],
  "status": "available"
  }
    """
    When method post
    Then status 200
    And match response.id == 12345
    And match response.category.id == 1
    And match response.category.name == "cats"
    And match response.name == "Chonky Boy"
    And match response.photoUrls contains "https://www.cats.com/ChonkyBoy.jpg"
    And match response.tags[0].id == 1
    And match response.tags[0].name == "Fuzzy"
    And match response.status == "available"


#  Scenario Outline: As a user, I would like to add new pets to the store
#    Given url 'https://petstore.swagger.io/v2/pet'
#    And request
#    """
#    {
#    "id": <id>,
#  "category": {
#  "id": <categoryId>,
#  "name": "<categoryName>"
#  },
#  "name": "<petName>",
#  "photoUrls": [<photoUrl>],
#  "tags": [
#  {
#    "id": <tagId>,
#  "name": "<tagName>"
#  }
#  ],
#  "status": "<status>"
#  }
#    """
#    When method post
#    Then status 200
#    And match response.id == <id>
#    And match response.category.id == <categoryId>
#    And match response.category.name == "<categoryName>"
#    And match response.name == "<petName>"
#    And match each response.photoUrls contains <photoUrl>
#    And match response.tags[0].id == <tagId>
#    And match response.tags[0].name == "<tagName>"
#    And match response.status == "<status>"
#
#    Examples:
#    |id|categoryId|categoryName|petName|photoUrl|tagId|tagName|status|
##    |900 |900|"cats"|"Jooy"|["https://www.cats.com/Jooy.jpg"]|1|"Fluffs"|"available"|
##    |5550|5550|"dogs"|"Max"|["https://www.cats.com/Max.jpg"]|1|"Adorable"|"available"|
##    |55550|55550|"dogs"|"Bruno"|["https://www.cats.com/Bruno.jpg"]|1|"Adorable"|"available"|
##    |123 |1|"cats"|"Ana"|["https://www.cats.com/Ana.jpg"]|1|"Adorbs"|"available"|
##  |12|12        |"cats"      |"Test" |["https://www.cats.com/Test,jpg"]|1|"Fluffy"|"available"|
#    |1 |1         |"cats"      |"Name" |["https://www.cats.com/Name.jpg"]|1|"playful"|"available"|


    Scenario: As a user, I would like to delete a pet
      Given url  'https://petstore.swagger.io/v2/pet/9223372036854775807'
      When method delete
      Then status 200
      And match response.code == 200
      And match response.type == "unknown"
      And match response.message == "9223372036854775807"


  Scenario Outline: As a user, I would like to delete pets by petId
    Given url  'https://petstore.swagger.io/v2/pet/<petId>'
    When method delete
    Then status 200
    And match response.code == 200
    And match response.type == "unknown"
    And match response.message == "<petId>"

    Examples:
    |petId|
    |9223372036854775807    |
    |1   |
    |2  |
    |3|
    |4|
