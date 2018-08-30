@isTest
private class NewCommissionOnOpp_Test {

    /*Creating data factory for custom setting*/
    @testSetup
    public static void createNewCommissionOnOpp_DataFactory() {
        TriggerSetting__c record = new TriggerSetting__c();
        record.Opportunity__c = true;
        insert record;
    }
    
    
        /*Test method to test Trigger custom setting*//*
    static testMethod void testing_ItsParent() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.opportunity__c  == true) { 
            Test.startTest();
            NewCommissionOnOpp_DataFactory obj = new NewCommissionOnOpp_DataFactory();
            obj.createCommissionOpp(1, true);
            TrainingData__Commission__c record = 
            [Select TrainingData__Opportunity__r.OwnerId, 
            TrainingData__Opportunity__r.Name, TrainingData__Opportunity__c,
            Owner.Name, OwnerId From TrainingData__Commission__c ];
            
            System.assertEquals(OwnerId , record.TrainingData__Opportunity__r.OwnerId);

            System.assert(record.id != Null);
            Test.StopTest();
        }
    }*/
   
    
       /*Test method to test Trigger custom setting*/
    static testMethod void testMethodForTrigger() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.opportunity__c  == false) { 
            Test.startTest();
            NewCommissionOnOpp_DataFactory obj = new NewCommissionOnOpp_DataFactory();
            obj.createCommissionOpp(400, true);
            Test.StopTest();
            System.assertEquals(0,[select id from TrainingData__Commission__c].size());
            List<AggregateResult> count_List =
            [select count(id), TrainingData__Opportunity__c from 
            TrainingData__Commission__c group by TrainingData__Opportunity__c];
            system.assertEquals(0, count_List.size());
            for(AggregateResult result : count_List) {
                system.assert(result.get('expr0') == 0);
            }
        }
    }
    
    
    
    /*Test method to test Trigger with satisfying criteria*/
    static testMethod void testMethodForSatisfiedCriteria() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.opportunity__c  == true) { 
           Test.startTest();
           NewCommissionOnOpp_DataFactory obj = new NewCommissionOnOpp_DataFactory();
           obj.createCommissionOpp(400, true);
           Test.StopTest();
           System.assertEquals(400, [select id from Commission__c].size());
        
            List<AggregateResult> count_List =
            [select count(id), TrainingData__Opportunity__c from 
            TrainingData__Commission__c group by TrainingData__Opportunity__c];
            
            system.assertEquals(400, count_List.size());
            for(AggregateResult result : count_List) {
                system.assert(result.get('expr0') != 0);
            }
        }
    }
    
    /*Test method to test Trigger in which criteria is partial satisfied*/
    static testMethod void testMethodForPartialSatisfiedCriteria() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.opportunity__c  == true) { 
           Test.startTest();
           NewCommissionOnOpp_DataFactory obj = new NewCommissionOnOpp_DataFactory();
           obj.createCommissionOpp(300, true);
           obj.createCommissionOpp(200, false);
           Test.StopTest();
           System.assertEquals(300, [select id from Commission__c].size());

           
           List<AggregateResult> count_List =
            [select count(id), TrainingData__Opportunity__c from 
            TrainingData__Commission__c group by TrainingData__Opportunity__c];
            
            system.assertEquals(300, count_List.size());
            for(AggregateResult result : count_List) {
                system.assert(result.get('expr0') != 0);
            }
        }
    }
    
    
    /*Test method to test Trigger for updation*/
    static testMethod void testMethodForUpdationCriteria() {
        TriggerSetting__c  object_CustomSetting =
        TriggerSetting__c.getOrgDefaults();
        if(object_CustomSetting.opportunity__c  == true) { 
           list<opportunity> updated_List = new list<opportunity> ();
           Test.startTest();
           NewCommissionOnOpp_DataFactory obj = new NewCommissionOnOpp_DataFactory();
           list<opportunity> oppList = obj.createCommissionOpp(350, false);
           list<Commission__c> com_List1 = [select id from Commission__c];
           system.assertEquals(0, com_List1.size());
           for(opportunity record : oppList) {
               record.Contact_Completed__c = true;
               updated_List.add(record);
            }
            update updated_List;
           Test.StopTest();
          System.assertEquals(350, [select id from Commission__c].size());

           
           List<AggregateResult> count_List =
            [select count(id), TrainingData__Opportunity__c from 
            TrainingData__Commission__c group by TrainingData__Opportunity__c];
            
            system.assertEquals(350, count_List.size());
            for(AggregateResult result : count_List) {
                system.assert(result.get('expr0') != 0);
            }
        }
    }
}