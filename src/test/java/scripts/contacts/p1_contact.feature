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

  Scenario: Create a contact with invalid details
    Given path apiConstant.create_contact
    * set payload.properties[?(@.name=='first_name')].value = null
    * set payload.properties[?(@.name=='last_name')].value = null
    * set payload.properties[?(@.name=='email')].value = null
    * set payload.properties[?(@.name=='title')].value = null
    And request payload
    When method post
    Then status 500

  Scenario: Update contact and validate
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def first_name = 'ravindra'
    * def last_name = 'kadagoudar'
    * set response.properties[?(@.name=='first_name')].value = first_name
    * set response.properties[?(@.name=='last_name')].value = last_name
    Given path apiConstant.update_contact
    And request response
    When method put
    Then status 200
    * match response.properties[?(@.name=='first_name')].value contains first_name
    * match response.properties[?(@.name=='last_name')].value contains last_name

  Scenario: Update lead score of contact By id
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * set response.lead_score = 10
    Given path apiConstant.update_lead_score
    And request response
    When method put
    Then status 200
    * match response.lead_score == 10

  Scenario: Delete the tag of the contact
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * def contactId = response.id
    When path apiConstant.delete_tag_by_id
    * def createdContact = response
    And request createdContact
    When method put
    Then status 200
    * def apiPath = apiConstant.get_contacts_by_id
    * replace apiPath.${id} = contactId
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


