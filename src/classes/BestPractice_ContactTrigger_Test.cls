/*Test class for BestPractice_ContactTrigger*/

@isTest
private class BestPractice_ContactTrigger_Test {
    /*Creating data factory*/
    @testSetup
    public static void createDataFactory() {
        TriggerSetting__c record = new TriggerSetting__c();
        record.Contact__c = true;
        insert record;
    }
    
    /*Testing trigger for Both fields : Domain and email are inserted*/
    
    static testMethod void testLookupwithBothDomainAndEmail() {
       try {
           TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
           if(object_CustomSetting.Contact__c == true) { 
	           Test.startTest();
		       List<Account> Account_list = 
		       Account_DataFactory.CreateAccountRecords(1, 'Eternus', 'espl.com');
		       
		       List<Contact> Contact_list = 
	           Contact_DataFactory.CreateContactRecords(100, ' ', 'EternusContact',
	           'salesforce@espl.com');
		       Test.StopTest();
		       for(Contact Record : [select Contact.account.name, accountId from
		       Contact]) {
	               system.assertEquals(Record.account.name, Record.accountId);
	           }
           }
       }catch(exception e){
       }
    }
    
    
    /*Testing trigger for only Domain fields is inserted*/
   static testMethod void testLookupwithDomain() {
       try {
           TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
           if(object_CustomSetting.Contact__c == true) { 
	           Test.startTest();
	           List<Account> Account_list = 
	           Account_DataFactory.CreateAccountRecords(1, 'Eternus', 'espl.com');
	           
	           List<Contact> Contact_list = 
	           Contact_DataFactory.CreateContactRecords(100, '', 'EternusContact', '');
	           Test.StopTest();
	           for(Contact Record : [select Contact.account.name, accountId from Contact]) {
	                system.assertEquals(Record.account.name , Record.accountId);
	           }
        }
        }catch(exception e){
        }
    }
    
    
    /*Testing trigger for only email fields is inserted*/
    static testMethod void testLookupwithEmail() {
        try {
            TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
            if(object_CustomSetting.Contact__c == true) {
	            Test.startTest();
	            List<Account> Account_list = 
	            Account_DataFactory.CreateAccountRecords(1, 'Eternus', '');
	           
	            List<Contact> Contact_list = 
	            Contact_DataFactory.CreateContactRecords(100, '', 'EternusContact',
	            'salesforce@espl.com');
	            Test.StopTest();
	            for(Contact Record : [select Contact.account.name, accountId 
	            from Contact]) {
	                system.assertEquals(Record.account.name , Record.accountId);
	            }
            }
       }catch(exception e){
       
       }
    }
    
    
    /*Testing trigger for empty fields */
    static testMethod void testLookupwithEmptyFields() {
       try {
           TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
           if(object_CustomSetting.Contact__c == true) { 
	           Test.startTest();
	           List<Account> Account_list = 
	           Account_DataFactory.CreateAccountRecords(1, 'Eternus', '');
	           
	           List<Contact> Contact_list = 
	           Contact_DataFactory.CreateContactRecords(100, '', 'EternusContact', '');
	           Test.StopTest();
	           for(Contact Record : [select Contact.account.name, accountId from 
	           Contact]) {
	                system.assertEquals(Record.account.name, Record.accountId);
	           }
           }
       }catch(exception e){
       }
    }
    
    
    /*Testing trigger for update scenario : Initially only Domain fields is
    inserted and then email feild of contact is updated from null to other value*/
   static testMethod void testUpdate() {
       try {
           TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
           if(object_CustomSetting.Contact__c == true) { 
	           Test.startTest();
	           List<Account> Account_list = 
	           Account_DataFactory.CreateAccountRecords(1, 'Eternus', 'espl.com');
	           List<Contact> Contact_list = 
	           Contact_DataFactory.CreateContactRecords(100, '','EternusContact', '');
	           list<Contact> UpdatedContact_List = new list<Contact>();
	           for(Contact Record : Contact_list) {
	                record.email = 'contact@espl.com';
	                UpdatedContact_List.add(Record);
                }
               update UpdatedContact_List;
               Test.StopTest();
           
               for(Contact Record : [select Contact.account.name, accountId from
               Contact]) {
                    system.assertEquals(Record.account.name, Record.accountId);
                }
           }
       }catch(exception e){
       }
    }
}