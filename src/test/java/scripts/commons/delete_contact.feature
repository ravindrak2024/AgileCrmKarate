@Ignore
Feature: Delete all contact

  Background:
    * url baseUrl
#    * def rawHeader = read('classpath:configs/headers.js')
#    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read('classpath:scripts/commons/company_api_constants.feature')

  Scenario: Get all companies and delete them
    * def apiPath = apiConstant.delete_contact
    * replace apiPath.${id} = contactId
    Given path apiPath
    When method delete
    Then status 204