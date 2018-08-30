public with sharing class ECS_9_DMLOperations {
    
    /*Query on Account object/ records and show/print each account record using 
    a. Traditional for loop 
    b. Advanced for loop
    c. While loop*/
 
    public void accountLoop()
    {
        try{
            integer index;
            list<account> acc = [select id, name, phone from account];
            for(account accvar : acc)
            {
                system.debug('=====1======'+accvar.id);
                system.debug('=====1======'+accvar.name);
                system.debug('=====1======'+accvar.phone);
            }
            
            for(index = 0; index < acc.size(); index++)
            {
                system.debug('=====2======'+acc[index].id);
                system.debug('=====2======'+acc[index].name);
                system.debug('=====2======'+acc[index].phone);
            }
            
            while(index < acc.size())
            {
                system.debug('=====3======'+acc[index].id);
                system.debug('=====3======'+acc[index].name);
                system.debug('=====3======'+acc[index].phone);
                index++;
            }
        }catch(exception e){
            
        }
    }
    
    
    
    /*Query on all Lead records & add ID of record to the set and print that set
    .*/
    
    public void leadSet()
    {
        try{
            List<lead> leadList= [select id from lead];
            set<id> lset = new set<id>();
            for(Lead l:leadList)
                lset.add(l.id);
            System.debug(lset);
        }catch(exception e) {
            
        }
    }
    
    
    
    /* Create a Account Record with Name =”Eternus”. Create associated contacts
    .Create a Custom field called Contact Count on Account . Query on Contact
    where Account.Name =”Eternus” and count the associated contacts. Update
    the custom field on Accounts with that count*/

    public void createRelationship()
    {
         try{
             account acc = new account(name = 'Shruti');
             insert acc;
             
             list<contact> contactList = new list<contact>();
             contact contactObj;
             for(integer index = 0; index < 4; index++)
             {
                contactObj = new contact(lastname = 'williams'+index, 
                             accountid = acc.id);
                contactList.add(contactObj); 
             } 
             insert contactList;
             
             list<contact> clist = [select id from contact 
                                    where accountid =:acc.id];
             integer size = clist.size();
             system.debug('*********'+size);
             /*integer countvar= database.countQuery
             ('select count(account.name)'+'
                                                    'from contact where '+
                                                    'account.name = \'eternus\''
                                                    );
                                                    
             system.debug('the count is '+ countvar);
             */
             acc.count__c = size;
             System.debug(size);
             update acc;
        }catch(exception e){
        }
    
    }
    
    
    /*Find all the Lead records having Status as Won & update the stage with 
    New value*/
    
    public void updateLead()
    {
        try{
            list<lead> leadlist = new list<lead>([select id, lastname, company,
                                                 status__c from lead where 
                                                 status__c = 'won']);
            system.debug(leadlist);
            for(lead l : leadlist){
                l.stage__c = '100%';
            }
            update leadlist;
        }catch(exception e){
        }
    }
    
    
    
    /*Write a SQOL Query to show Child Parent relationship and print the result
    */

    public void parentChild()
    {
        try{
            list<Opportunity> opp = [select id, account.name, amount, name from 
                                    Opportunity];
            for(Opportunity oppobj : opp){
                System.debug('++++++child to parent '+oppobj);
            }
            list <account> acc = [select id, name, (select lastname from
                                 contacts) from account where name = 'eternus'];
            for(account accobj : acc){
                System.debug('-------Parent to child '+accobj);
            }
        }catch(exception e){
            
        }
    }


    /*Write a SOQL query to retrieve/print the Account records where Created 
    Date = Today*/


    public void AccountCreatedDate()
    {
        try{
            list<account> acclist = [select id, name, accountnumber from account
                                     where createddate = today];
            System.debug(acclist);
        }catch(exception e){
        
        }
    }
    


    /*Demonstrate the usage of Database.query method*/

    public void databaseQueryDemo()
    {
        try{
            
            string a= 'select id,name from employee__c';
            list<sObject> dblist = Database.query(a);
            System.debug('+++++++'+dblist);   
            
            
        }catch(exception e){
            
        }
    }

    
    /*Demonstrate the usage of Database.search method*/
    
    public void databaseSearchDemo(){
        try{
            string query = 'find {sonali} in all fields returning account'+
                            '(TrainingData__Enrollment_Year__c),'+
                             'TrainingData__Employee__c';
            
            list<list<sObject>> acc = search.query(query);
            System.debug(acc);
            
            for(list<sObject> innerList : acc){
                System.debug(innerList); 
                //System.debug(innerList.acc[1]);
            }
            for(account accessField : (list<account>)acc[0]){
                System.debug
                ('Year------'+accessField.TrainingData__Enrollment_Year__c);
            }
            
        }catch(exception e){
        
        }
    }
}