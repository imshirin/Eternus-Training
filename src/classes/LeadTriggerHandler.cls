/*HandlerClass to handle trigger on lead*/

public with sharing class LeadTriggerHandler {
    public void method_LeadTriggerHandler(){
        try{
            if (Trigger.isBefore) {
                if (Trigger.isInsert) {
                    System.debug(Trigger.New);
                    System.debug(Trigger.NewMap);

                }
                if(Trigger.isDelete){
		            System.debug(Trigger.oldMap);
		            System.debug(Trigger.old);
                }
            }
            
            if (Trigger.isAfter) {
                if(Trigger.isInsert){
		            System.debug(Trigger.NewMap);
                    System.debug(Trigger.oldMap);
                    System.debug(Trigger.New);
                    System.debug(Trigger.old);
                    
                }
                if(Trigger.isUpdate){
		            System.debug(Trigger.oldMap);
                    System.debug(Trigger.newMap);
                    System.debug(Trigger.New);
                    System.debug(Trigger.old);
                }
            }
         }catch(exception e){

         }
    }
}