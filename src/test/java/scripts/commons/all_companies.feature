@Ignore
Feature: Delete all companies

  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth',{'Content-Type':'application/x-www-form-urlencoded'})
    * def apiConstant = call read('classpath:scripts/commons/company_api_constants.feature')

  Scenario: Get all companies and delete them
    * def apiPath = apiConstant.list_company
    Given path apiPath
    And form field page_size = '1000'
    And form field global_sort_key = '-created_time'
    And form field radius = '10'
    When method post
    Then status 200
    And def allcompanies = karate.jsonPath(response, "$..id" )
