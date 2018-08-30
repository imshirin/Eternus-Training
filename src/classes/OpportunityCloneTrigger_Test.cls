/*Test class for cloning opportunity record*/
@isTest
private class OpportunityCloneTrigger_Test {

    /*Creating data factory*/
    @testSetup
    public static void createDataFactory() {
        TriggerSetting__c record = new TriggerSetting__c();
        record.Opportunity__c = true;
        insert record;
    }
    
    /*Test class to check whether a single record id cloned or not*/
    static testMethod void testClonedSingleRecord() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.Opportunity__c  == true) { 
	        list<opportunity> opplist = new list<opportunity>();
	         
	        /*Starts the test here*/
	        Test.startTest();
	        DataFactory d = new DataFactory();
	        d.createOpportunity1(1);
	        /*Ends the scope of test*/
	        Test.stopTest();
	        /*Check if another clone record is created in opportunity object*/
	        opplist = [select id from opportunity];
	        system.assertEquals(2,opplist.size());
        }
    }
    /*Test class to check whether a trigger works for Bulk of data*/
    static testMethod void testClonedBulkRecord() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.Opportunity__c  == true) { 
	        list<opportunity> opplist = new list<opportunity>();
	        /*Starts the test here*/
	        Test.startTest();
	        DataFactory d = new DataFactory();
	        d.createOpportunity1(450);
	        /*Ends the scope of test*/
	        Test.stopTest();
	        /*Check if another clone record is created in opportunity object*/
	        opplist = [select id from opportunity];
	        system.assertEquals(900,opplist.size());
	    }
    }
    
}