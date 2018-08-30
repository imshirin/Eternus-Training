/*Handler on trigger of opportunity*/

public with sharing class OpportunityCloneTriggerHandler {
    private static boolean flag = true;
    
    /*Method to clone records*/
    public void method_OpportunityCloneTriggerHandler(list <opportunity> oppList)
    {
        List<Opportunity> cloneList = new  List<Opportunity> ();
        if(CheckFlag.Check()) {
            cloneList = oppList.deepclone();
	        System.debug('--------'+cloneList);
	        insert cloneList;
        }
    }
}