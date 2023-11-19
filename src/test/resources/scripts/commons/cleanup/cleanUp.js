
function cleanUp(id){
        karate.call('classpath:scripts/commons/delete_company.feature',{companyId:id})
}
