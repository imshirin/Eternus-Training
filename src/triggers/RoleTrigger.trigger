/*System.debug the following statements for any object
a)Trigger.New b) Trigger.Old c)Trigger.NewMap d)Trigger.oldMap*/

trigger RoleTrigger on TrainingData__Role__c (before insert) {
    TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
    if(object_CustomSetting.Opportunity__c  == true) { 
	    try{
	            System.debug(trigger.new);
	            System.debug(trigger.old);
	            System.debug(trigger.newmap);
	            System.debug(trigger.oldmap);
	    
	    }
	    catch(exception e){
	    }
    }
}