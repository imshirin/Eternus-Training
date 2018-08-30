@isTest
/*Creating data factory*/

public with sharing class DataFactory {
    
    /*Inserting records of Opportunity object*/
    public static list<opportunity> createOpportunity(integer numberOfRecords, string oppName)
    {
        list<opportunity> opplist = new list<opportunity>();
        opportunity oppObject;
        for(integer index = 0; index < numberOfRecords; index++){
            oppObject = new opportunity(Name = oppName,
            CloseDate = date.today(), StageName = 'Id. Decision Makers');
            opplist.add(oppObject);
        }
        insert opplist;
        return opplist;
    }
    
       public list<opportunity> createOpportunity1(integer numberOfRecords)
    {
        list<opportunity> opplist = new list<opportunity>();
        opportunity oppObject;
        for(integer index = 0; index < numberOfRecords; index++){
            oppObject = new opportunity(Name = 'John',
            CloseDate = date.today(), StageName = 'Id. Decision Makers');
            opplist.add(oppObject);
        }
        insert opplist;
        return opplist;
    }
    
   
 /*Inserting records of CampaignMember object*/
    public list<CampaignMember> createCampaignMember(integer numberOfRecords,
    String lead_RSVP, string CM_RSVP) {   
        Campaign c = new campaign(Name = 'Test');
        insert c;
        list<CampaignMember> CMlist = new list<CampaignMember>();
        list<lead> leadlist = new list<lead>();
        
        CampaignMember CMRecord;
        lead leadRecord;
        
        for(integer index = 0; index < numberOfRecords; index++) {
            leadRecord= new Lead(lastname='espl'+index, company='ESPL',
            TrainingData__RSVP__c = lead_RSVP);
            leadlist.add(leadRecord);
          
        }
          insert leadlist;
        for(integer index = 0; index < numberOfRecords; index++) {
            CMRecord =  new CampaignMember 
            (campaignid=c.id, leadid=leadlist[index].id, 
             TrainingData__RSVP__c = CM_RSVP);
            CMlist.add(CMRecord);
        }
        insert CMlist;
        CMlist = [select id from CampaignMember];
        return CMlist;
    }
}