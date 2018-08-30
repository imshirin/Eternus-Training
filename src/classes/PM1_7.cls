//Demonstrate the usage of Database.query and Database.search methods

public with sharing class PM1_7 {
    public void database()
    {
        try{
            
            string a= 'select id,name from employee__c';
            list<sObject> dblist = Database.query(a);
            System.debug(dblist);   
            
            
        }catch(exception e){
            
        }
    }
    
}