/*Handler for removing duplicate lead*/

public with sharing class Batch_RemoveDuplicateLead_Handler {
    static list <lead> delete_List = new list <lead> ();
    static set <string> compare_set = new set <string> ();
    
    public static  void methodExecute (list <lead> lead_List) {
        LeadRedundancy__c setting = LeadRedundancy__c.getInstance();
        
        if((setting.Name__c && setting.Phone__c && setting.Email__c)) {
            for(lead leadObj : lead_List) {
                
                if((leadObj.name != NULL && leadObj.MobilePhone != NULL && leadObj.Email != NULL) &&
                (!compare_set.contains(leadObj.name))) {
                    compare_set.add(leadObj.name);
                }
                else {
                    delete_List.add(leadObj);
                }
            }
        }
        
        else {
	        if(setting.Name__c) {
	            for(lead leadObj : lead_List) {
	                if(!compare_set.contains(leadObj.name)) {
	                    compare_set.add(leadObj.name);
	                }
	                else {
	                    delete_List.add(leadObj);
	                }
	            }
	        }
	        
	        else if(setting.Phone__c) {
	            for(lead leadObj : lead_List) {
	                if(!compare_set.contains(leadObj.MobilePhone)) {
	                    compare_set.add(leadObj.MobilePhone);
	                }
	                else {
	                    delete_List.add(leadObj);
	                }
	            }
	        }
	        
	        else if(setting.Email__c) {
	            for(lead leadObj : lead_List) {
	                if(!compare_set.contains(leadObj.Email)) {
	                    compare_set.add(leadObj.Email);
	                }
	                else {
	                    delete_List.add(leadObj);
	                }
	            }
	        }
        }
        
        delete delete_List;
    }
}