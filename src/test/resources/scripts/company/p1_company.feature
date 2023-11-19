@smoke
Feature: Create and get Company
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url baseUrl
    * def rawHeader = read('classpath:configs/headers.js')
    * configure headers = rawHeader('BasicAuth')
    * def apiConstant = call read(COMMONS_PATH+'/company_api_constants.feature')
    * def random_data = call read(COMMONS_PATH+'/random_data.feature')
    * def createCompany = call read(COMMONS_CLEANUP_PATH+'/createCompany.js')
    * def companyId = createCompany.companyId
    * def companyName = createCompany.companyName
    * def companyResponse = createCompany.companyResponse
    * def deleteCompany = read(COMMONS_CLEANUP_PATH+'/cleanUp.js')
    * configure afterScenario =
    """
    function(){
      deleteCompany(companyId)
    }
    """

  Scenario: create and get all company
    * def apiPath = apiConstant.get_company
    * replace apiPath.${id} = companyId
    Given path apiPath
    When method get
    Then status 200
    * print myVarName
    * def expectedResponse = read(RESPONSE_PAYLOAD_PATH+'/createCompanyResponse.json')
    * match response == expectedResponse
    * match response.properties[?(@.name=='name')].value contains companyName

  Scenario: Update an existing company.
    * def updatedCompanyName = 'Persistent Systems'
    * def updatedCompanyUrl = 'https://www.persistentsystems.com'
    * set companyResponse.properties[?(@.name=='name')].value = updatedCompanyName
    * set companyResponse.properties[?(@.name=='url')].value = updatedCompanyUrl
    Given path apiConstant.update_company
    And request companyResponse
    When method put
    Then status 200
    * def expectedResponse = read(RESPONSE_PAYLOAD_PATH+'/createCompanyResponse.json')
    * set expectedResponse.properties[?(@.name=='name_lower')].type = 'CUSTOM'
    * match response == expectedResponse
    * match response.properties[?(@.name=='name')].value contains updatedCompanyName