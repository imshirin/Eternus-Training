/*Unable to Cross Ship
 1.Create SalesHeader__c object :(Having lookup to Account & Contact ) & Add 
 necessary fields.
 2. Create assignment record type on Case
On Insert or update of a SalesHeader__c, if
SalesHeader__c.Status__c = “Open”
SalesHeader__c.Pick_Status__c = “Open”
SalesHeader__c.Total_Amount__c > 300
\\ Evaluate Bill to and Ship to fields to see if they match, if there is any
difference, create a case
IF (SalesHeader__c.Bill_to_Street__c <> SalesHeader__c.Ship_to_Street__c, OR
SalesHeader__c.Bill_to_City__c <> SalesHeader__c.Ship_to_City__c; OR
SalesHeader__c.Bill_to_Postal_Code__c <> SalesHeader__c.Ship_to_Postal_Code__c
OR SalesHeader__c.Bill_to_State__c <> SalesHeader__c.Ship_to_State__c )
Then create a case*/

trigger SalesHeader_Trigger on TrainingData__SalesHeader__c (after insert, before update) {
    TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
    if(object_CustomSetting.SalesHeader__c  == true) { 
	    If (Trigger.isInsert || Trigger.isUpdate) {
	        try {
		    SalesHeaderTrigger_Header object_SalesHeaderTrigger_Header = 
		    new SalesHeaderTrigger_Header();
		    object_SalesHeaderTrigger_Header.method_SalesHeaderTrigger(trigger.new);
	        }catch(exception e) {
	        }
		}
    }
}