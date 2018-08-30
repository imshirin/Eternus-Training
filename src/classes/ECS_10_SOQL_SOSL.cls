public with sharing class ECS_10_SOQL_SOSL{
    /*Query on all Contact records, adding them to the List and Printing 
    contents of list.*/
    
    public void displayContacts()
    {
        try {
            list<contact> contactList =
            [select id, firstname, lastname from contact];
            for(contact cobj : contactList){            
                System.debug(cobj.id);
                system.debug('--------'+cobj.firstname);
                System.debug('*****'+cobj.lastname);
            }
            }
        catch(Exception e) {
        }
    }
    
    
    /* SOQL query to retrieve and print all active Users. Preparing a Map having
    User Id as key and User record as value*/
    
    
    public void UserInfo() {
        try {
            map<id, user> userMap =new map<id, user>([SELECT Id, username FROM 
                                                     User WHERE isactive = true]
                                                    );
               System.debug(userMap);
        } catch(exception e){
        
        }
    }
    
    
    

    /*Prepare the map structures - Account Name as key and AccountId as value.*/
    
    public void MaptoStoreNameAndId(){
        try{
            list<account> acclist= [SELECT Id, name 
                                    FROM account];
            map<string, id> accountMap =new map<string, id>();
            for(account obj : acclist){
                accountMap.put(obj.name, obj.id);
            }
            System.debug(accountMap);
        }catch(exception e){
        }
    
            }
    
    /*Account Id as key and entire Account object as value.*/
    
    public void MaptoStoreIdAndAccount(){
        try{
                map<id, account> accountMap =new map<id, account>
                ([SELECT Id, name FROM account]);
                System.debug(accountMap);
            }catch(exception e){ 
            }
    }
    
    
    /*Get all account records where in selected 'Enrollment Year' is:
    a. 2010
    b. 2013 and 2014*/

    public void getEnrollmentYear()
    {
        try{
           list<account> acc = new list<account>
           ([select id, name, accountnumber, TrainingData__Enrollment_Year__c 
           from account where(TrainingData__Enrollment_Year__c = '2010')
           OR (TrainingData__Enrollment_Year__c includes ('2013') AND
           TrainingData__Enrollment_Year__c includes('2014'))]);
           for(account accObj : acc){
                system.debug(accObj);
           }
        }catch(exception e){
            
        }
    }
    
    
    /*'Maharashtra' and'Kerala'. Ordering the results by Billing State in
    descending order with null values at the end. Displaying first 10,000
    records only without use AND operator*/


    public void getAccountRecords()
    {
        try{
            list<account> acc = new list<account>
            ([select id, name, BillingState from account where BillingState not
            in ('Maharashtra', 'Kerala') order by BillingState desc NULLS LAST
            limit 10000]);
            for(account accObj : acc){
                System.debug('Id============='+accObj.id);
                System.debug('Name-----------'+accObj.name);
                System.debug('BillingState***'+accObj.BillingState);
            }
        }catch(exception e){
        }
    }


    /* SOQL query to display 100 opportunity records with amount greater than
    10,000 order by created date. Skip first 50 records and include records from 
    recycle bin.*/ 

    public void getOpportunities(){
        try{
            Integer j = 10, cost = 9900;
            
            List <opportunity> opplist = new List <opportunity>();
            for(Integer i = 1; i<= 100; i++){
                Opportunity oppInsert = new Opportunity
                (name='opportunity'+i, stagename='Qualification', closedate=
                system.today(), amount = cost+j);
                opplist.add(oppInsert);
            }
            insert opplist;
            
            opplist = [select id, name, amount, createddate
            from Opportunity where amount > 10000 AND isDeleted = true order by
            createddate desc offset 50];
            for(Opportunity oppObj : opplist){
                system.debug(oppObj.id);
                system.debug(oppObj.name);
                system.debug(oppObj.amount);
                system.debug(oppObj.createddate);
            }
        }catch(exception e){
        
        }
    }
    
    
    /*SOQL query to retrieve sum of all closed Opportunity amount for current
    fiscal year. Store this information in a map with key as year and value as
    sum of amount. Iterate this map to display statistics.*/
    
    public void aggregateQueryonMap()
    {
        try{
                Integer currentYear = System.today().year(); 
                aggregateResult[] result = 
                [Select fiscalYear, sum(Amount)sumAmount From Opportunity where
                IsClosed = true group by FiscalYear];
                Map<integer,  object> mapList = new Map<integer,  object>();
                maplist.put(currentYear,result[0].get('sumAmount'));        
                System.debug('======='+maplist);
            }catch(exception e){
        
        }
        
    }


    /* Finding total number of distinct Lead records on basis of 'Lead Source'
     having greater than 10 leads.Printing this information*/
     
     
    public void aggregateQueryonLead(){ 
        try{
                aggregateResult[] result =
                [SELECT LeadSource, COUNT(id)FROM Lead GROUP BY LeadSource
                 HAVING COUNT(leadsource) > 10];
                for(integer index = 0; index < result.size(); index++)
                {
                    System.debug('Leadsource'+ (index+1) +'----'+
                    result[index].get('leadsource') );
                    System.debug('count----'+result[index].get('expr0'));
                
                }
                
            }catch(exception e){
        }
    }
    
    
    /* Write a SOQL query to find total number of Lead records by status by Lead
    Source. Store this information in map and display the same.
    (Hint: map<string,map<string,integer>>)*/
    
    
    public void aggregateQueryonMapofMap(){
        try{
            aggregateResult[] result = 
            [SELECT Status, LeadSource, COUNT(id) FROM Lead GROUP BY
             Status, LeadSource];
            Map<string,Map<string,integer>> outermap = 
            new Map<string,Map<string,integer>> ();
                for(aggregateResult index: result)
                {
                    string leadSourceString, statusString;
                    integer countNumber;         
                    leadSourceString = String.valueOf(index.get('LeadSource'));
                    statusString = String.valueOf(index.get('Status'));
                    countNumber = integer.valueOf(index.get('expr0'));
                    if(!outermap.containsKey(statusString)){
                        outermap.put(statusString, new Map<string,integer>());
                    }
                    outermap.get(statusString).put(leadSourceString,
                    countNumber);
                 }
                 System.debug(outermap);
            
        }catch(exception e){
        }
    }
    
    
    
    /* Write a SOQL query on Contact to retrieve all active contacts belonging
    to 'media' Industry. Also display the name of the account to which it is
    associated to.*/
    
    
    public void queryonChildToParentContacttoAccount()
    {
        try{
                list<contact> clist = 
                [Select c.LastName, c.FirstName, 
                c.Account.TrainingData__Active__c, c.Account.Industry,
                c.Account.Name, c.AccountId From Contact c where
                c.Account.Industry = 'media' AND
                c.Account.TrainingData__Active__c = 'yes'];
                for(contact cobj : clist){
                    System.debug(cobj.LastName+'----'+cobj.FirstName+'----'+
                    cobj.FirstName+'----'+cobj.Account.TrainingData__Active__c+
                    '----'+ cobj.Account.Industry+'----'+cobj.Account.Name+
                    '----'+ cobj.AccountId);}
            }catch(exception e){
            
        }
    }
    
 
    
    /*Write SOQL query on 'C'(created above) to retrieve all records of 'C'
    with name 'John' along with parent details.*/
    
    
    public void queryonChildToParentJunctionObject_C()
    {
        try{
               list<TrainingData__C__c> clist =
               [Select t.TrainingData__B__r.Name, t.TrainingData__B__c,
               t.TrainingData__A__r.Name, t.TrainingData__A__c, t.Name From
               TrainingData__C__c t WHERE t.Name LIKE '%john%'];
               
               for(TrainingData__C__c cobj : clist)
                    System.debug(cobj.TrainingData__A__c+'----'+
                    cobj.TrainingData__A__r.Name+'----'+
                    cobj.TrainingData__B__c+'----'+
                    cobj.TrainingData__B__r.Name+'----'+C__c.Name);
                }catch(exception e){
            
        }
    }
    
    
    
    /* Write a SOQL query to find all Account records which have at least an
    opportunity record which is 'Closed Won'*/
    
    
      public void queryOnParentToChildOpportunitytoAccount()
    {
        try{
                list<account> acclist = [SELECT Id, Name, accountnumber, (SELECT
                 Id, Name, StageName FROM Opportunities where
                 StageName ='Closed Won' AND opportunity.id!= NULL)
                 FROM Account];
                 for(account accobj : acclist){    
                    System.debug(accobj.id+'----'+accobj.Name+'----'+accobj.accountnumber);
                 }
              }catch(exception e){
            
        }
    }

    
    
    /* Write a SOQL query on Account and find all associated contact records of
    the Account which contains the word 'John'. Print all Account and Contact
    records retrieved above.*/
    
    
    public void queryOnParentToChildAccounttoContact()
    {
        try{
                list<account> acclist = [Select Id,name, (Select Id, email From
                Contacts ) From Account where id in(select accountid from 
                contact WHERE Name Like '%John%')];
                for(account accobject : acclist){
                    System.debug(accobject);
                }
            }

        catch(exception e){
            
        }
    }
        
        
    
    /*Write a SOQL query on 'A' and retrieve all parents with all their child
     records where in child name is John'.*/
     
     
     public void queryA_retrieveAllChild(){
         try{
             list<TrainingData__A__c> AList = [Select t.Name, (Select Name,
             TrainingData__A__r.name, TrainingData__B__r.name From
             TrainingData__C__r  where TrainingData__B__r.name like '%john%')
             From TrainingData__A__c t];
             System.debug(AList);
             
         }catch(exception e){
             
         }
     }
    
    
    
    
    
    /*SOSL-Find the word 'test' in all name fields returning Contact, Account,
    Lead and User.*/
    
    
    public void soslQuery(){
    
        try{
                string query = 'find {test} in all fields returning Account'+
                '(name, accountnumber), Contact(id, firstname, lastname),'+
                'Lead (id,Company), User(id, name)';
				list<list<sObject>> objectList = search.query(query);
				Account[] AccountList = (Account[])objectList[0];
				Contact[] ContactList = (Contact[])objectList[1];
				Lead[] LeadList = (Lead[])objectList[2];
				User[] UserList = (User[])objectList[3];
				
				
				System.debug('Accounts record----------');
				for (Account accobject : AccountList) {
				    System.debug('Id --'+accobject.id);
				    System.debug('Name --'+accobject.Name);
				}
				System.debug('\n');
				
				System.debug('Contacts record----------');
				for (Contact contactobj : ContactList) {
				    System.debug('FirstName --'+contactobj.FirstName);
				    System.debug('LastName --'+contactobj.LastName);
				}
				System.debug('\n');
				
				System.debug('Lead record----------');
				for (Lead Leadobject : LeadList) {
				    System.debug('Id --'+Leadobject.id);
				    System.debug('Company --'+Leadobject.Company);
				}
				System.debug('\n');
				
				System.debug('User record----------');
				for (User Userobject : UserList) {
				    System.debug('Id --'+Userobject.id);
				}
				System.debug('\n');
        }catch(exception e){
            
        }
    }
    
    
    
    /* Create a custom object called as 'Logs'. Create a long text area field
    called as 'Error'. Create 100 Lead records using DML operations having a
    unique name. For all records which were not inserted into Lead object,
    insert a record in Log object along with the reason why a record was not
    inserted. Also, execute assignment rules to auto allocate Lead records to
    correct owner*/
    

   public void createLeadRecords_Logs()
   {
       List<Lead> leadList = new List<Lead>();
       Lead leadRecord;
       AssignmentRule ARule = new AssignmentRule();
       ARule = [select id from AssignmentRule where SobjectType = 'Lead' and
       Active = true];
       Database.DMLOptions dmlOptions = new Database.DMLOptions();
       dmlOptions.assignmentRuleHeader.assignmentRuleId= ARule.id;
        
        //Inserting correct record
       for(Integer index = 0; index <9 ; index++)
       {
           leadRecord = new Lead(FirstName='Lead'+ index ,
                                 LastName='Record'+index,
                                 Company='ESPL',
                                 City='Nashik',
                                 Status='Open - Not Contacted');
           leadRecord.setOptions(dmlOptions);
           leadList.add(leadRecord);
       }
       
       // Not inserted required field
       for(Integer index = 0; index < 2; index++)
       {
           leadRecord = new Lead(FirstName='Lead'+index,
                                 Company='ESPL',
                                 Status='Open - Not Contacted');
           leadRecord.setOptions(dmlOptions);
           leadList.add(leadRecord);
       }

       Database.SaveResult[] saveList = Database.insert(leadList,false);
       List<TrainingData__Log__c> logList = new List<TrainingData__Log__c>();
       TrainingData__Log__c logRecord;
       for(Database.SaveResult saveRecord : saveList)
       {
           if(!saveRecord.isSuccess())
           {
               String errorMessage;
               for(Database.Error error : saveRecord.getErrors())
               {
                   errorMessage = errorMessage + error.getMessage();
               }
               logRecord = new Log__c(Error__c=errorMessage);
               logList.add(logRecord);
           }
       }
       insert logList;
   }

    
    
    /* Delete all inactive Account records created in last 90 days.*/
    
    public void deleteLead(){
        try{
                List <account> acclist = new List <account>([Select id,
                createddate, TrainingData__Active__c from account where
                TrainingData__Active__c = 'no' AND CreatedDate = 
                LAST_N_DAYS:90]);
                
                System.debug(acclist);
                delete acclist;
            
            }catch(exception e){
        }
    
    }
}