@Ignore
Feature: Generates random timestamp based data, like company name etc.

  Scenario: Get timestamp based data
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def companyName = "company_" + env + "_" + now() + "_" + Math.floor(Math.random() * Math.floor(1000))
    * def companyUrl = "https://"+companyName+".com"

    * def contactFirstName = 'testUser'
    * def contactLastName = 'lastname_'+Math.floor(Math.random() * Math.floor(1000))
    * def contactEmailId = contactFirstName+'_'+ contactLastName+'@yopmail.com'
    * def randomTitleGenerator =
    """
    function getRandomItem() {
    const array = ['CEO', 'Manager', 'Team Leader', 'Sales Manager','Operations Manager','QA Manager','Sales Executive'];
    // get random index value
    const randomIndex = Math.floor(Math.random() * array.length);

    // get random item
    const item = array[randomIndex];

    return item;
}
    """
    * def contactTitle = randomTitleGenerator()


