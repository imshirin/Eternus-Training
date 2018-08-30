@isTest
public class Account_DataFactory {

    public static list<account> CreateAccountRecords(integer numberOfRecords, String Accountname, String domain){
        list <account> account_List = new list <account> ();
        account record;
        for(integer index = 1; index <= numberOfRecords; index++){
            record = new account(name = Accountname+index ,domain__c = domain);
            account_List.add(record);
        }
        insert account_List;
        return(account_List);
    }
    
    /*Data factory used for dynamic apex*/
     public static list<account> CreateRecords(integer numberOfRecords, String Accountname){
        list <account> account_List = new list <account> ();
        account record;
        for(integer index = 1; index <= numberOfRecords; index++){
            record = new account(name = Accountname+index);
            account_List.add(record);
        }
        insert account_List;
        return(account_List);
    }
}