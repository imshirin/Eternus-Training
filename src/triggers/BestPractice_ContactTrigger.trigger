/*ABC Containers require the ability to automatically associate a Contact
created in their Salesforce Instance with the respective Account based on the
email domain specified in the primary email address of the Contact. The
association should happen real time as soon as a Contact record is created
within the system*/


trigger BestPractice_ContactTrigger on Contact (before insert, before update)  {
    TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
    if(object_CustomSetting.Contact__c == true) { 
	    try{
	        IF (Trigger.isInsert || Trigger.isUpdate) {           
	            BestPractice_ContactTrigger_Handler object_BestPractice_ContactTrigger_Handler
		        = new BestPractice_ContactTrigger_Handler();
		        object_BestPractice_ContactTrigger_Handler.method_object_BestPractice_ContactTrigger_Handler(trigger.new);
	        }
	    }catch(exception e){
	    }
    }
}