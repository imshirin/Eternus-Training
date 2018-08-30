//. Write a SOQL query to retrieve/print the Account records where Created Date 
//= Today

public with sharing class PM1_6 {
    public void AccountCreatedDate()
    {
        try{
            list<account> acclist = [select id, name, accountnumber from account where createddate = today];
            System.debug(acclist);
        }catch(exception e){
        
        }
    }
    
}