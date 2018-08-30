trigger InsertAccountTrigger on Account (before update) {
    TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
    if(object_CustomSetting.Account__c  == true) { 
        try{
            for(Account ac :trigger.new ) {
                ac.accountnumber = '88888';
            }
        }catch(exception e) {
        }
    }
}