@ignore
Feature: Create contact

  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read(COMMONS_PATH+'/company_api_constants.feature')
    * def random_data = call read(COMMONS_PATH+'/random_data.feature')
    * def payload = read(REQUEST_PAYLOAD_PATH+'/contactPayload.json')

  Scenario: Create a contact
    Given path apiConstant.create_contact
    * print random_data.contactEmailId
    And request payload
    When method post
    Then status 200
    * match response.properties[?(@.name=='first_name')].value contains random_data.contactFirstName
    * def contactId = response.id
    * def contactResponse = response
    * def emailId = random_data.contactEmailId

