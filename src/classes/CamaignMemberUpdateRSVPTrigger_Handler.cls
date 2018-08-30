/*Handler to handle trigger on CamaignMember to Update RSVP*/
    
public with sharing class CamaignMemberUpdateRSVPTrigger_Handler {

    public void method_CamaignMemberUpdateRSVPTrigger
    (List<CampaignMember> ListOfCampaignMember) {
       try{ 
            TriggerSetting__c  object_CustomSetting =TriggerSetting__c.getOrgDefaults();
            if(object_CustomSetting.CampaignMember__c  == true) { 
                List<CampaignMember> CampaignMemberList = new List<CampaignMember>();
                CampaignMemberList = [SELECT TrainingData__RSVP__c,
                lead.TrainingData__RSVP__c From CampaignMember WHERE 
                Id IN :ListOfCampaignMember and RSVP__c=''];
                for(CampaignMember CampaignMemberObject: CampaignMemberList){
                    CampaignMemberObject.TrainingData__RSVP__c = 
                    CampaignMemberObject.lead.TrainingData__RSVP__c;
                }
            update CampaignMemberList;
            }
        }catch(exception e){
        }
    }
}