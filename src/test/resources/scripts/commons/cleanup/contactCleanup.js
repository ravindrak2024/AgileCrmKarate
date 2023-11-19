
function cleanUp(id){
        karate.call('classpath:scripts/commons/delete_contact.feature',{contactId:id})

}