/* Create a Account Record with Name =”Eternus”. Create associated contacts.
Create a Custom field called Contact Count on Account . Query on Contact
where Account.Name =”Eternus” and count the associated contacts. Update
the custom field on Accounts with that count*/

public with sharing class PM1_3{
    public void createRelationship()
    {
         try{
             account acc = new account(name = 'eternus');
             insert acc;
             
             for(integer index = 0; index < 4; index++)
             {
                contact contactObj = new contact(lastname = 'williams'+index, accountid = acc.id);
                insert contactObj; 
             }
             integer countvar= database.countQuery('select count(account.name) from contact where account.name = \'eternus\'');
             system.debug('the count is '+ countvar);
             
             acc.count__c = countvar;
             System.debug(countvar);
             update acc;
             
             }catch(exception e){
            
        }
    }
    
}