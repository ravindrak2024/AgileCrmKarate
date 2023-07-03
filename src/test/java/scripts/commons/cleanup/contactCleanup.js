function cleanUp(){
    var result = karate.call('classpath:scripts/commons/all_contacts.feature')

    result.allcontacts.forEach((id)=>{
        karate.call('classpath:scripts/commons/delete_contact.feature',{contactId:id})
    })
}