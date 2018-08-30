/*Test class for collection of close won opportunity batch*/

@isTest
private class Batch_ClosedWonOpportunity_Test {

    @testSetup
    
    public static void dataFactory () {
        list <account> fetchedAcc_List;

        /*Add Account records*/
        list <account> account_List = new list <account> ();
        account accRecord;
        for(integer index = 1; index <= 1; index++){
            accRecord = new account(name = 'Test'+index);
            account_List.add(accRecord);
        }
        insert account_List;
        fetchedAcc_List = [select id from account];
       
        
        /*Add Contact records*/
        list <contact> contact_List = new list <contact> ();
        contact conRecord;
        for(integer index = 0; index < 1; index++){
            conRecord = new contact(lastname = 'Contact'+index,
            email = 'shirin@espl.com', accountId = fetchedAcc_List[index].id);
            contact_List.add(conRecord);
        }
        insert contact_List;
        
        
        /*Add AccountContactRole records*/
       List<AccountContactRole> role_List = new List<AccountContactRole>();
       for (Contact cont : contact_List) {
           AccountContactRole role = new AccountContactRole();
           role.AccountId = cont.AccountId;
           role.ContactId = cont.Id;
           role.role = 'other';
           role.IsPrimary = true; 
           role_List.add(role);
       }
       insert role_List;
       
        
        
        /*Add Opportunity records*/
        list<opportunity> opplist1 = new list<opportunity>();
        opportunity oppObject;
        for(integer index = 0; index < 1; index++){
            oppObject = new opportunity(Name = 'John'+index,
            CloseDate = date.today(), accountId = fetchedAcc_List[index].id,
            StageName = 'Closed Won', amount = 7000);
            opplist1.add(oppObject);
        }
        insert opplist1;
    
    
        /*Add Opportunity records*/
        list<opportunity> opplist2 = new list<opportunity>();
        opportunity oppRecord;
        for(integer index = 0; index < 1; index++){
            oppRecord = new opportunity(Name = 'Bob'+index,
            CloseDate = date.today(), accountId = fetchedAcc_List[index].id,
            StageName = 'Closed Won', amount = 3000);
            opplist2.add(oppRecord);
        }
        insert opplist2;
    }
    
    /*Test method for testing functionality of Account object*/
    static testMethod void testAccount() {
        list <account> fetchedAccount_List;
        Test.StartTest();
        fetchedAccount_List = [select id from account];
        System.assertEquals(1, fetchedAccount_List.size());
        Test.StopTest();
    }
        

    /*Test method for testing functionality of Contact object*/
    static testMethod void testContact() {
        list <contact> fetchedContact_List;
        Test.StartTest();
        fetchedContact_List = [select id,email from contact];
        System.assertEquals(1, fetchedContact_List.size());
        for(contact con : fetchedContact_List) {
            System.assertEquals('shirin@espl.com', con.email);
        }        
        Test.StopTest();
    }
        

    /*Test method for testing functionality of Opportunity object*/
    static testMethod void testOpportunity1() {
        list <opportunity> fetchedOppprtunity_List1;
        Test.StartTest();
        fetchedOppprtunity_List1 = [select id, name, amount from opportunity where amount = 7000];
        System.assertEquals(1, fetchedOppprtunity_List1.size());
        for(opportunity opp : fetchedOppprtunity_List1) {
            System.assertEquals(7000, opp.amount);
        }
                
        Test.StopTest();
    }
    
    
     /*Test method for testing functionality of Opportunity object*/
    static testMethod void testOpportunity2() {
        list <opportunity> fetchedOppprtunity_List2;
        Test.StartTest();
        fetchedOppprtunity_List2 = [select id, name, amount from opportunity where amount = 3000];
        System.assertEquals(1, fetchedOppprtunity_List2.size());
        Test.StopTest();
        for(opportunity opp : fetchedOppprtunity_List2) {
            
            System.assertEquals(3000, opp.amount);
        }

    }
    
    
    /*Test method for testing functionality of AccountContactRole object*/
    static testMethod void AccountContactRole() {
        list <AccountContactRole> fetchedACR_List;
        fetchedACR_List = [select id, isPrimary from AccountContactRole];
        System.assertEquals(1, fetchedACR_List.size());
        Test.StartTest();
        for(AccountContactRole acr : fetchedACR_List) {
            System.assertEquals(true, acr.isPrimary);
        }
        Test.StopTest();
    }
        
    /*Test method for testing functionality of execute method of Batch*/
    static testMethod void test() {
        Batch_ClosedWonOpportunity obj = new Batch_ClosedWonOpportunity ();
        Test.StartTest();
        ID batchprocessid = Database.executeBatch(obj,500);
        Test.StopTest();
        
    }
        
        
        
    }