@isTest
private class SearchInAccountManager_Test {

    static testMethod void searchSuccessfullTest()
    {
       test.startTest();
           List<Account> accountList = 
           Account_DataFactory.CreateAccountRecords(100,'Account', '');
           ApexPages.StandardSetController stdController =
           new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s = 
           new SearchForAccountManagerExtension(stdController);
           s.searchText = 'Acc';
           s.searchRecords();
       test.stopTest();
       System.assertEquals(100,s.countOfRows);
    }
   
   static testMethod void searchFailTest()
   {
       test.startTest();
           List<Account> accountList = 
           Account_DataFactory.CreateAccountRecords(100,'Account', '');
           ApexPages.StandardSetController stdController =
           new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s=
           new SearchForAccountManagerExtension(stdController);
           s.searchText = 'Ac';
           s.searchRecords();
           test.stopTest();
       System.assertEquals(false,s.show);
   }
   
   static testMethod void clearTest()
   {
       test.startTest();
           List<Account> accountList =
           Account_DataFactory.CreateAccountRecords(100,'Account', '');
           ApexPages.StandardSetController stdController =
           new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s =
           new SearchForAccountManagerExtension(stdController);
           s.clearSearch();
           test.stopTest();
       System.assertEquals(true,s.show);
       System.assertEquals(100,s.countOfRows);
   }
}