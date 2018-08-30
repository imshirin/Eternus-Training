@isTest
public class NewCommissionOnOpp_DataFactory {

 /*Data factory for creating new commission record*/
    public list<opportunity> createCommissionOpp(integer numberOfRecords, boolean test)
    {
        list<opportunity> opplist = new list<opportunity>();
        opportunity oppObject;
        for(integer index = 0; index < numberOfRecords; index++){
            oppObject = new opportunity(Name = 'John',
            CloseDate = date.today(), StageName = 'Id. Decision Makers',
            Contact_Completed__c = test);
            opplist.add(oppObject);
        }
        insert opplist;
        return opplist;
    }
    
}