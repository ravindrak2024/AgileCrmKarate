@Ignore
Feature: Delete all companies

  Background:
    * url baseUrl
#    * def rawHeader = read('classpath:configs/headers.js')
#    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read('classpath:scripts/commons/company_api_constants.feature')

  Scenario: Get all companies and delete them
    * def apiPath = apiConstant.delete_company
    * replace apiPath.${id} = companyId
    Given path apiPath
    When method delete
    Then status 204