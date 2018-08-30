/*Trigger to clone opportunity record and create new record of commission*/


trigger OpportunityCloneTrigger on Opportunity (before insert,before update) {
    try {
        TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.Opportunity__c  == true) { 
            OpportunityCloneTriggerHandler object_OpportunityCloneTriggerHandler =
            new OpportunityCloneTriggerHandler();
            if(Trigger.isbefore) {
                /*Business logic to call before insertion of opportunity*/
                if(Trigger.isInsert) {
                    object_OpportunityCloneTriggerHandler.method_OpportunityCloneTriggerHandler(trigger.new);
                }
            }
        }
    }catch(exception e) {
    }
}