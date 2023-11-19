@Ignore
Feature: Delete all companies

  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read('classpath:scripts/commons/company_api_constants.feature')

  Scenario: Get all contacts
    * def apiPath = apiConstant.get_contacts
    Given path apiPath
    When method get
    Then status 200
    And def allcontacts = karate.jsonPath(response, "$..id" )
