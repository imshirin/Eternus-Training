/*1.System.debug the following statements for any object
a)Trigger.New
b) Trigger.Old
c)Trigger.NewMap
d)Trigger.oldMap*/


trigger LeadTrigger on Account (after insert, after update, before insert,
before update) {
    TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
    if(object_CustomSetting.Lead__c  == true) { 
	    try{
	            LeadTriggerHandler LeadTriggerHandlerObject = new
	            LeadTriggerHandler();
	            LeadTriggerHandlerObject.method_LeadTriggerHandler();
	    }catch(exception e){
	    }
    }
}