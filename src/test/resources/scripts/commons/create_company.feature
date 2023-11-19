@ignore
Feature: Create company

  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read('classpath:scripts/commons/company_api_constants.feature')
    * def random_data = call read(COMMONS_PATH+'/random_data.feature')
    * def payload = read(REQUEST_PAYLOAD_PATH+'/companyPayload.json')

  Scenario: create a company
    Given path apiConstant.create_company
    And request payload
    When method post
    Then status 200
    * def companyId = karate.jsonPath(response,'$.id')
    * def companyName = random_data.companyName
    * def companyResponse = response
