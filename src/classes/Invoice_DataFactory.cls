@isTest
public class Invoice_DataFactory {

     public static Invoice__c createInvoiceRecords() {
   
       List<Contact> contacts = Contact_DataFactory.CreateContactRecords(1, '','','');
       Invoice__c invoice = new Invoice__c();
       invoice.Contact__c = contacts[0].id;
       invoice.Date__c = Date.valueOf('2017-03-03');
       invoice.ChargesPerLabour__c=2000;
       invoice.totalNumberOfLabour__c=10;
       invoice.Service_Charges__c = 10000;
       invoice.Tax__c = 15;
       invoice.Discount__c = 20;
       insert invoice;
       return invoice;
   }
}