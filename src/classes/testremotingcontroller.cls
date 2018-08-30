public with sharing class  testremotingcontroller {
    @RemoteAction
    public static Account[] searchAccounts(String accountName) {
        // support * search like salesforce lookups
        accountName = accountName.replaceAll('[*]', '%');
        return [select id, name, phone, type, numberofemployees from 
             Account where name like :accountName ];
        
    }   
}