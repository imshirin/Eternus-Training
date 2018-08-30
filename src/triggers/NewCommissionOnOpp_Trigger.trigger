trigger NewCommissionOnOpp_Trigger on Opportunity (after insert, after update) {
    try {
        TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.Opportunity__c  == true) { 
            NewCommissionOnOpp_Handler object_NewCommissionOnOpp_Handler =
            new NewCommissionOnOpp_Handler();
            if(Trigger.isAfter) {
                /*Business logic to call before insertion of opportunity*/
                if(Trigger.isInsert || Trigger.isUpdate) {
                    object_NewCommissionOnOpp_Handler.method_CreateCommission(trigger.new);
                }
            }
        }
    } catch(exception e) {
    
    }
}