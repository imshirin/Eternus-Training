/*Handler for trigger on Contact*/

public with sharing class BestPractice_ContactTrigger_Handler {
   
    public void method_object_BestPractice_ContactTrigger_Handler(list<contact> clist){
         map<string , id> map_Email = new  map<string , id>();
        for(account accobj : [select id, name, domain__c
        from account where domain__c != null]){ 
            map_Email.put(accobj.domain__c, accobj.id);
        }
        if(!map_Email.isEmpty()) {
            for(contact c : clist) {
                if(c.Email!=null) {
				        string contactDomain = c.Email.split('@').get(1);
				        c.accountId = map_Email.get(contactDomain); 
				}
            }
        }
    }
}