/*Campaign member Trigger
Whenever a Campaign member of type lead is inserted, check the RSVP field on
campaign member, if it is blank and if the Lead RSVP field has value we would
need to update that value on the Campaign member RSVP field*/

trigger CamaignMemberUpdateRSVPTrigger on CampaignMember (after insert, after update) {
    TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
    if(object_CustomSetting.CampaignMember__c  == true) { 
	    try {
		    CamaignMemberUpdateRSVPTrigger_Handler object_CamaignMemberUpdateRSVPTrigger_Handler
		    = new CamaignMemberUpdateRSVPTrigger_Handler();
		    object_CamaignMemberUpdateRSVPTrigger_Handler.method_CamaignMemberUpdateRSVPTrigger(trigger.new);
	    } catch(exception e) {
	    }
    }
}