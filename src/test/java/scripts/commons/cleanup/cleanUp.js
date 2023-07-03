function cleanUp(){
    var result = karate.call('classpath:scripts/commons/all_companies.feature')

    result.allcompanies.forEach((id)=>{
        karate.call('classpath:scripts/commons/delete_company.feature',{companyId:id})
    })
}