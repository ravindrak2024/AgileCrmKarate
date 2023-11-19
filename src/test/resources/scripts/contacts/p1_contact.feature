@smoke
Feature: Create and get Contact
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support



  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read(COMMONS_PATH+'/company_api_constants.feature')
    * def random_data = call read(COMMONS_PATH+'/random_data.feature')
    * def contact = call read(COMMONS_PATH+'/create_contact.feature')
    * def contactId = contact.contactId
    * def contactResponse = contact.contactResponse
    * def contactEmailId = contact.emailId
    * def deleteContact = read(COMMONS_CLEANUP_PATH+'/contactCleanup.js')
    * configure afterScenario =
    """
    function(){
      deleteContact(contactId)
    }
    """
    * def payload = read(REQUEST_PAYLOAD_PATH+'/contactPayload.json')


  Scenario Outline: Create a contact with invalid details __row
    Given path apiConstant.create_contact
    * set payload.properties[?(@.name=='first_name')].value = <first_name>
    * set payload.properties[?(@.name=='last_name')].value = <last_name>
    * set payload.properties[?(@.name=='email')].value = <email>
    * set payload.properties[?(@.name=='title')].value = <title>
    And request payload
    When method post
    Then status <statusCode>

    Examples:
      | first_name   | last_name    | email | title         |statusCode |
      | null         | null         | null  | null          | 500       |
      | null         | null         | null  | 'Sr Manager'  | 500       |
      | null         | 'shah'       | null  | 'Sr Manager'  | 500       |
      | 'amit'       | 'shah'       | null  | 'Sr Manager'  | 500       |

  Scenario: Update contact and validate
    * def update_contactId = contactResponse.id
    * def update_fname = 'ravindra'
    * def update_lname = 'kadagoudar'
    * def update_email = 'abc@yopmail.com'
    * def updatePayload = read(REQUEST_PAYLOAD_PATH+'/updateContactPayload.json')
    Given path apiConstant.update_contact
    And request updatePayload
    When method put
    Then status 200
    * match response.properties[?(@.name=='first_name')].value contains update_fname
    * match response.properties[?(@.name=='last_name')].value contains update_lname


  Scenario Outline: Update contact with invalid details and validate
    Given path apiConstant.update_contact
    * def updatePayload = read(REQUEST_PAYLOAD_PATH+'/updateContactPayload.json')
    And request updatePayload
    When method put
    Then status <statusCode>
    * print response
    * assert response.contains(<message>)
    Examples:
      | update_contactId   | update_fname   | update_lname     | update_email            |statusCode | message                                     |
      | 98792552           | 'amit'         | 'shinde'         | 'amit@yopmail.com'      | 400       | 'Contact is not availabe for given id.'     |
      |                    | 'amit'         | 'shinde'         | 'amit@yopmail.com'      | 400       | 'Please check id value should not be null.' |

  Scenario: Delete the tag of the contact
    * def deleteTagBy_contactId = contactResponse.id
    * def tagsPresent = contactResponse.tags
    * def deleteBytagPayload =
    """
    {
    "id": "#(deleteTagBy_contactId)",
    "tags": '#(tagsPresent)'
    }
    """
    When path apiConstant.delete_tag_by_id
    * def createdContact = contactResponse
    And request deleteBytagPayload
    When method put
    Then status 200
    * def apiPath = apiConstant.get_contacts_by_id
    * replace apiPath.${id} = deleteTagBy_contactId
    When path apiPath
    When method get
    Then status 200
    * match response.tags == []

  Scenario: Search contact by email_id
    * def apiPath = apiConstant.search_contact_by_email
    * replace apiPath.${emailId} = contactEmailId
    When path apiPath
    And method get
    Then status 200
    * match response.id == contactId

  Scenario: Get all contacts and validate the size
    * def contactId = contactResponse.id
    * def result = call read('classpath:scripts/commons/all_contacts.feature')
    * assert result.allcontacts.length > 0
