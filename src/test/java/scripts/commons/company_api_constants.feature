@Ignore
Feature: Saves api constants

  Scenario: Get all the api constants for company
    * def create_company = '/'+apiEnvPath+'/api/contacts'
    * def list_company = '/'+apiEnvPath+'/api/contacts/companies/list'
    * def delete_company = '/'+apiEnvPath+'/api/contacts/${id}'
    * def get_company = '/'+apiEnvPath+'/api/contacts/${id}'
    * def update_company = '/'+apiEnvPath+'/api/contacts/edit-properties'

#  UpdateContact=/api/contacts/edit-properties
#  UpdateLeadScore=/api/contacts/edit/lead-score
#  UpdateTagById=/api/contacts/edit/tags
#  DeleteTagById=/api/contacts/delete/tags
#  DeleteContact=/api/contacts/{id}

#  SearchContactByEmail=/api/contacts/search/email/
#  AddTagsToContact=/api/contacts/email/tags/add
#  DeleteTagsOnContactByEmail=/api/contacts/email/tags/delete
#  AddScoreToContact=/api/contacts/add-score
#  GetTaskOfContact=/api/contacts/{contact_id}/tasks/sort
#  UpdateContactPropertyByEmail=/api/contacts/add/property
#  ChangeContactOwner=/api/contacts/change-owner
#  AddContactToCampaing=/api/campaigns/enroll/email
#  RemoveContactFromACampaign=/api/workflows/remove-active-subscriber/{workflow-id}/{contact_id}
#  GetContactByPhoneNumber=/api/contacts/search/phonenumber/{phone-number}
#  GetContactByDynamicFilter=/api/filters/filter/dynamic-filter

    * def get_contacts = '/'+apiEnvPath+'/api/contacts'
    * def get_contacts_by_id = '/'+apiEnvPath+'/api/contacts/${id}'
    * def create_contact = '/'+apiEnvPath+'/api/contacts'
    * def update_contact = '/'+apiEnvPath+'/api/contacts'
    * def update_lead_score = '/'+apiEnvPath+'/api/contacts/edit/lead-score'
    * def update_tag_by_id = '/'+apiEnvPath+'/api/contacts/edit/tags'
    * def delete_tag_by_id = '/'+apiEnvPath+'/api/contacts/delete/tags'
    * def delete_contact = '/'+apiEnvPath+'/api/contacts/${id}'
    * def search_contact_by_email = '/'+apiEnvPath+'/api/contacts/search/email/${emailId}'
