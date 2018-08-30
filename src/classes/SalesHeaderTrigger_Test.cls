/*Test class for SalesHeaderTrigger_Test*/
@isTest
public with sharing class SalesHeaderTrigger_Test {
    
    /*Creating data factory*/
    @testSetup
    public static void createDataFactory() {
        TriggerSetting__c record = new TriggerSetting__c();
        record.CampaignMember__c = true;
        insert record;
    }
    
    /*Test method to test Trigger with satisfying criteria*/
    static testMethod void testMethodForSatisfiedCriteria() {
        TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.SalesHeader__c  == true) { 
	       Test.startTest();
	       List<SalesHeader__c> salesHeader_list = 
	       SalesHeader_DataFactory.createSalesHeaders(50, 500, 1, 'yahoo.com');
	       Test.StopTest();
	       list<case> caseList = [select id from case];
	       system.assertEquals(50, caseList.size());
        }
    }
    
    /*Test method to test Trigger in which criteria is not satisfied*/
    
    static testMethod void testMethodForUnsatisfiedCriteria() {
        TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.SalesHeader__c  == true) { 
	       Test.startTest();
	       List<SalesHeader__c> salesHeader_list = 
	       SalesHeader_DataFactory.createSalesHeaders(100, 200, 1, 'yahoo.com');
	       Test.StopTest();
	       list<case> caseList = [select id from case];
	       system.assertEquals(0, caseList.size());
        }
    }
    
    
    /*Test Method for records with some satisfying criteria and rest
    unsatisfying criteria*/
    
    static testMethod void testMethodForPartialSuccessfulRecords() {
         TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
         if(object_CustomSetting.SalesHeader__c  == true) { 
	         Test.startTest();
		     List<SalesHeader__c> salesHeader_CriteriaSatisfying_list = 
		     SalesHeader_DataFactory.createSalesHeaders(40, 500, 1, 'yahoo.com');
		     List<SalesHeader__c> salesHeader_CriteriaUnsatisfying_list = 
		     SalesHeader_DataFactory.createSalesHeaders(60, 200, 50, 'gmail.com');
		     Test.StopTest();
		     list<case> caseList = [select id from case];
		     system.assertEquals(40, caseList.size());
         }
    }
    
    /*Test Method for update scenario*/
     static testMethod void testMethodForUpdation() {
        TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.SalesHeader__c  == true) { 
	        Test.startTest();
	        List<SalesHeader__c> salesHeader_list = 
	        SalesHeader_DataFactory.createSalesHeaders(100, 200, 1, 'yahoo.com');
	        Test.StopTest();
	        list<SalesHeader__c> UpdatedSHList = new list<SalesHeader__c>();
	        for(SalesHeader__c record : salesHeader_list) {
	            record.Total_Amount__c = 500;
	            UpdatedSHList.add(record);
	        }
	        update UpdatedSHList;
	        list<case> caseList = [select id from case];
	        system.assertEquals(100, caseList.size());
        }
    }
}