/*Handler on trigger of opportunity*/

public with sharing class NewCommissionOnOpp_Handler {
    
    /*method which creates new commission record*/
    public void method_CreateCommission(list <opportunity> oppList) {
        integer i = 0;
        list<Commission__c> com_List = new list<Commission__c> ();

        for(opportunity opp : oppList) {
            if(opp.Contact_Completed__c == true) {
                Commission__c record = new Commission__c ();
                record.name = 'commission'+i;
                record.Opportunity__c = opp.id;
                record.ownerId = opp.ownerId;
                com_List.add(record);
                i++;
            }
        }
        insert com_List;
    }
}