/*Test class for Batch_RemoveDuplicateLead*/

@isTest
private class Batch_RemoveDuplicateLead_Test {


    static testMethod void unCheckedCustomSettings() {
        List<Lead> leads = Lead_DataFactory.createBatchLeadReacord(400,'','','');
        LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = false;
        record.Name__c = false;
        insert record;
        test.startTest();
            Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj,400);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(400, leadList.size());
    }

    static testMethod void onlyName() {

        LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = false;
        record.Name__c = true;
        insert record;
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(300,'Eternus','','');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(300,'Eternus','','');
        test.startTest();
            Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj,600);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(300, leadList.size());
    }

    static testMethod void onlyNameWithNoDuplication() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','espl','7854698523');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'Persistent','espl','7854698523');

     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = false;
        record.Name__c = true;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size() + lead_List1.size(), leadList.size());
    }
    
    
    static testMethod void onlyEmail() {
        LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = true;
        record.Phone__c = false;
        record.Name__c = false;
        insert record;
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'','espl','');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'','espl','');
        test.startTest();
            Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(100, leadList.size());
    }
    


    static testMethod void onlyEmailWithNoDuplication() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','espl','7854698523');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','eternus','7854698523');

     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = true;
        record.Phone__c = false;
        record.Name__c = false;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size() + lead_List1.size(), leadList.size());
    }

    static testMethod void onlyPhone() {
        LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = true;
        record.Name__c = false;
        insert record;
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'','','7854698512');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'','','7854698512');
        test.startTest();
            Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(100, leadList.size());
    }
    


    static testMethod void onlyPhoneWithNoDuplication() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','espl','7854698523');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','espl','7854645523');

     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = true;
        record.Name__c = false;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size() + lead_List1.size(), leadList.size());
    }


    static testMethod void phoneNameCheckedWithDuplication() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(50,'Eternus','espl','');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(50,'Eternus','Persistent','');
        List<Lead> lead_List3 = Lead_DataFactory.createBatchLeadReacord(50,'Soniya','Persistent','8745632154');
        List<Lead> lead_List4 = Lead_DataFactory.createBatchLeadReacord(50,'Soniya','Persistent','8745632154');
        
     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = true;
        record.Name__c = true;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size() + lead_List3.size(), leadList.size());
    }

    static testMethod void phoneNameCheckedWithNameDuplication() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(50,'Eternus','espl','');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(50,'Eternus','Persistent','');
        List<Lead> lead_List3 = Lead_DataFactory.createBatchLeadReacord(50,'Soniya','Persistent','9995632154');
        List<Lead> lead_List4 = Lead_DataFactory.createBatchLeadReacord(50,'Sonali','Persistent','8745632154');
        
     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = false;
        record.Phone__c = true;
        record.Name__c = true;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size() + lead_List3.size() +  lead_List4.size(), leadList.size());
    }


    static testMethod void AllChecked() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','espl','7854698523');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','espl','7854645523');

     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = true;
        record.Phone__c = true;
        record.Name__c = true;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size(), leadList.size());
    }
    
    
        static testMethod void AllCheckedWithUnsatisfiedCriteria() {
        List<Lead> lead_List1 = Lead_DataFactory.createBatchLeadReacord(100,'Eternus','eternus','7845698523');
        List<Lead> lead_List2 = Lead_DataFactory.createBatchLeadReacord(100,'ESPL','espl','7854645523');

     LeadRedundancy__c record  = new LeadRedundancy__c();
        record.Email__c = true;
        record.Phone__c = true;
        record.Name__c = true;
        insert record;
        test.startTest();
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead();
            database.executeBatch(obj);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(lead_List1.size() + lead_List1.size(), leadList.size());
    }
}