@isTest
public class CampaignMemberTriggerTest {
    
    /*Creating data factory*/
    @testSetup
    public static void createDataFactory() {
        TriggerSetting__c record = new TriggerSetting__c();
        record.CampaignMember__c = true;
        insert record;
    }
    
    
    /*esting behaviour of trigger on insertion of LeadRSVP field*/
   static testMethod void testForInsertion_LeadRsvp() {
       TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
       if(object_CustomSetting.CampaignMember__c  == true) { 
           Test.startTest();
           DataFactory object_DataFactory = new DataFactory();
           object_DataFactory.createCampaignMember(200,'Yes', '');
           Test.stopTest();
           for(CampaignMember Record : [select RSVP__c,Lead.RSVP__c from CampaignMember])
           {
               system.assertEquals(Record.Lead.RSVP__c, Record.RSVP__c);
           }
       }
  }
  
  
    /*Testing behaviour of trigger on insertion of both Campaign member and
    Lead RSVP fields*/
   static testMethod void testForInsertion_BothRsvp() {
       TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
       if(object_CustomSetting.CampaignMember__c  == true) { 
           Test.startTest();
           DataFactory object_DataFactory = new DataFactory();
           object_DataFactory.createCampaignMember(200,'Yes', 'Can\'t say');
           Test.stopTest();
           for(CampaignMember Record : [select RSVP__c,Lead.RSVP__c from CampaignMember])
           {
               system.assertEquals('Can\'t say', Record.RSVP__c);
           }
       }
   }

   
    /*Testing behaviour of trigger on insertion of both field as null*/
  static testMethod void testForInsertion_NoRsvp() {
       TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
       if(object_CustomSetting.CampaignMember__c  == true) { 
           Test.startTest();
           DataFactory object_DataFactory = new DataFactory();
           object_DataFactory.createCampaignMember(200,'', '');
           Test.stopTest();
           for(CampaignMember Record : [select RSVP__c,Lead.RSVP__c from CampaignMember])
           {
               system.assertEquals(null, Record.RSVP__c);
           }
       }
   }

    /*Testing behaviour of trigger on insertion of only campaign member RSVP
    field*/
   static testMethod void testForInsertion_CampaignMemberRsvp() {
       TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
       if(object_CustomSetting.CampaignMember__c  == true) { 
           Test.startTest();
           DataFactory object_DataFactory = new DataFactory();
           object_DataFactory.createCampaignMember(200,'', 'Can\'t say');
           Test.stopTest();
           for(CampaignMember Record : [select RSVP__c,Lead.RSVP__c from CampaignMember])
           {
               system.assertEquals('Can\'t say', Record.RSVP__c);
           }
       }
   }


    /*Test Method to test behaviour of trigger on updation*/
    static testMethod void testForUpdation() {
       TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
       if(object_CustomSetting.CampaignMember__c  == true) { 
           Test.startTest();
           DataFactory object_DataFactory = new DataFactory();
           list<CampaignMember> CMList = 
           object_DataFactory.createCampaignMember(200,'Yes', '');
           list<CampaignMember> UpdatedCMList = new list<CampaignMember>();
           for(CampaignMember record : CMList) {
                record.RSVP__c = 'No';
                UpdatedCMList.add(record);
           }
           update UpdatedCMList;
           Test.stopTest();
           for(CampaignMember Record : [select RSVP__c from CampaignMember])
           {
               system.assertEquals('No', Record.RSVP__c );
           }
       }
   }
}