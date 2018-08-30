/*Best Practice 2 Test class*/
@isTest
private class ABC_Container_Test {


   public static testMethod void myUnitTest() {
      test.startTest();
           Invoice__c invoice = Invoice_DataFactory.createInvoiceRecords();
           ApexPages.StandardController stdController =
           new ApexPages.StandardController(invoice);
           ABC_Container_Extension s =
           new ABC_Container_Extension(stdController);
       test.stopTest();
       System.assertEquals(10000, s.invoice.Service_Charges__c);
       System.assertEquals(20000, s.invoice.Total_LabourCost__c);
       System.assertEquals(20, s.invoice.Discount__c);
       System.assertEquals(15, s.invoice.Tax__c);
       System.assertEquals(27600.00, s.invoice.Total__c);
   }
}