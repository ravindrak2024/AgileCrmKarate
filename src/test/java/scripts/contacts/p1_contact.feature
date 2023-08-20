@smoke
Feature: Create and get Contact
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support



  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read(COMMONS_PATH+'/company_api_constants.feature')
    * def random_data = call read(COMMONS_PATH+'/random_data.feature')
    * configure afterFeature = call read(COMMONS_CLEANUP_PATH+'/contactCleanup.js')
    * def payload = read(REQUEST_PAYLOAD_PATH+'/contactPayload.json')

  Scenario: Create a contact
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * match response.properties[?(@.name=='first_name')].value contains random_data.contactFirstName
    * print response
    * def expectedResponse = read(RESPONSE_PAYLOAD_PATH+'/createContactResponse.json')
    * match response == expectedResponse


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
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def update_contactId = response.id
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

  @smokex
  Scenario Outline: Update lead score of contact By id
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def leadScore_contactId = response.id
    * def leadScorePayload = __row
    * set leadScorePayload.id = leadScore_contactId
    * print leadScorePayload
    Given path apiConstant.update_lead_score
    And request leadScorePayload
    When method put
    Then status 200
    * match response.lead_score == leadScorePayload.lead_score
    Examples:
    |id                      |lead_score! |
    | #(leadScore_contactId) |20          |
    | #(leadScore_contactId) |30          |

  Scenario: Delete the tag of the contact
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def deleteTagBy_contactId = response.id
    * def tagsPresent = response.tags
    * def deleteBytagPayload =
    """
    {
    "id": "#(deleteTagBy_contactId)",
    "tags": #(tagsPresent)
    }
    """
    When path apiConstant.delete_tag_by_id
    * def createdContact = response
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
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def emailId = random_data.contactEmailId
    * def apiPath = apiConstant.search_contact_by_email
    * replace apiPath.${emailId} = emailId

  Scenario: Get all contacts and validate the size
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def contactId = response.id
    * def result = call read('classpath:scripts/commons/all_contacts.feature')
    * assert result.allcontacts.length > 0


